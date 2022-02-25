//
//  DetailViewController.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    let launcherViewModel = LauncherViewModel()
    var seletedUserId: Int = 0
    let activityIndicator = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Astronaut Details"
        Utilities.addSpinnerView(spinner: activityIndicator, on: self)
        
        userNameLbl.isHidden = true
        userImageView.isHidden = true
        detailTableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchUserDetails()
    }
    
    // API call to fetch Astronaut Details by id
    func fetchUserDetails(){
        
        if ReachabilityTest.isConnectedToNetwork() {
            self.launcherViewModel.fetchDetailedList(idValue: seletedUserId) { (completed) in
                if completed {
                    self.setUserNameandImage()
                    self.setupTableView()
                    return
                }else{
                    Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
                    let alert = Utilities.showSimpleAlert(message: "Could not fetch data. Please try again after sometime", title: "Failure")
                    self.present(alert, animated: false)
                }
            }
        }else{
            Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
            let alert = Utilities.showSimpleAlert(message: "No internet Connection", title: "Failure")
            self.present(alert, animated: false)
        }
    }
    
    // method set setup Astronaut details
    func setUserNameandImage(){
        
        userNameLbl.isHidden = false
        userImageView.isHidden = false
        userNameLbl.text = launcherViewModel.responseById?.name
        
        let imageUrl = launcherViewModel.responseById?.profile_image_thumbnail
        self.launcherViewModel.fetchImageFromURL(fetchUrl: imageUrl!) { (data, completed)  in
            if completed {
                DispatchQueue.main.async {
                    self.userImageView.image = UIImage(data: data)
                }
            }else{
                self.userImageView.image = UIImage(named: "DefaultProfileImage.png")
            }
        }
    }
    
    // Tableview configuration
    func setupTableView(){
        
        Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
        
        detailTableView.isHidden = false
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.reloadData()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        cell.isUserInteractionEnabled = false
        if indexPath.row == 0{
            cell.titleLbl.text = "Nationality"
            cell.userValueLbl.text = launcherViewModel.responseById?.nationality
        }else if indexPath.row == 1{
            cell.titleLbl.text = "Bio"
            cell.userValueLbl.text = launcherViewModel.responseById?.bio
        }else if indexPath.row == 2{
            cell.titleLbl.text = "Date Of Birth"
            cell.userValueLbl.text = launcherViewModel.responseById?.date_of_birth
        }else if indexPath.row == 3{
            cell.titleLbl.text = "Employment"
            cell.userValueLbl.text = launcherViewModel.responseById?.type?.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(LauncherViewController.initViewController(viewControllerIdentifier: "DetailViewController", fromStoryboard: "Main"), animated: false)
    }
    
}
