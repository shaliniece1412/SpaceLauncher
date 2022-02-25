//
//  LauncherViewController.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import UIKit

protocol sortingDelegate {
    func performsorting(order: String)
}

class LauncherViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var launcherTableView: UITableView!
    let launcherViewModel = LauncherViewModel()
    let activityIndicator = SpinnerViewController()
    var userArray: [ResultsResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Astronaut List"

        Utilities.addSpinnerView(spinner: activityIndicator, on: self)
        
        launcherTableView.isHidden = true
        launcherAPICall()
    }
    
    // Method to setup navigation bar items
    func setupNavigationItems(){
        let sortingBtn = UIBarButtonItem(title: "Sort By Name", style: .plain, target: self, action: #selector(sortBtnAction(sender:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = sortingBtn
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    // Method to handle sort bar button item click
    @objc func sortBtnAction(sender: UIBarButtonItem) {
        
        let popoverContent = LauncherViewController.initViewController(viewControllerIdentifier: "SortingDropDownViewController", fromStoryboard: "Main") as? SortingDropDownViewController
        popoverContent!.modalPresentationStyle = .popover
        if let popover = popoverContent?.popoverPresentationController {
            popover.barButtonItem = sender
            popoverContent!.preferredContentSize = CGSize(width: 150 ,height: 135)
        }
        popoverContent?.delegate = self
        self.present(popoverContent!, animated: true, completion: nil)
    }
    
    // Astronaut List API call
    func launcherAPICall(){
        
        if ReachabilityTest.isConnectedToNetwork() {
            self.launcherViewModel.fetchDetailedList(idValue: nil) { (completed) in
                if completed {
                    self.userArray = self.launcherViewModel.launcherResponse!.results
                    Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
                    self.setupNavigationItems()
                    self.launcherTableView.delegate = self
                    self.launcherTableView.dataSource = self
                    self.launcherTableView.isHidden = false
                    self.launcherTableView.reloadData()
                }else{
                    Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
                    let alert = Utilities.showSimpleAlert(message: "Could not fetch data. Please try again after sometime", title: "Failure")
                    self.present(alert, animated: false)
                }
            }
        }
        else{
            Utilities.removeSpinnerView(spinner: self.activityIndicator, on: self)
            let alert = Utilities.showSimpleAlert(message: "No internet Connection", title: "Failure")
            self.present(alert, animated: false)
        }
    }
    
}

extension LauncherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.launcherViewModel.launcherResponse?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lauchTableViewCell", for: indexPath) as! LauchTableViewCell
        cell.nameLabel.text = userArray[indexPath.row].name
        cell.nationalityLabel.text = userArray[indexPath.row].nationality
        cell.userStatusLbl.text = userArray[indexPath.row].status?.name
        let dateString = userArray[indexPath.row].first_flight
        if dateString != nil{
            let dateFormat = Utilities.convertDateFormat(inputDate: dateString!)
            cell.lastFlightLbl.text = dateFormat
            
        }
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: userArray[indexPath.row].wiki!, attributes: underlineAttribute)
        cell.wikiLinkLbl.attributedText = underlineAttributedString
        
        if userArray[indexPath.row].status?.name == "Active"{
            cell.userStatusLbl.textColor = .systemGreen
        }else{
            cell.userStatusLbl.textColor = .red
        }
        
        let imageUrl = userArray[indexPath.row].profile_image_thumbnail
        self.launcherViewModel.fetchImageFromURL(fetchUrl: imageUrl!) { (data, completed)  in
            if completed {
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data)
                }
            }else{
                cell.profileImageView.image = UIImage(named: "DefaultProfileImage.png")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = LauncherViewController.initViewController(viewControllerIdentifier: "DetailViewController", fromStoryboard: "Main") as? DetailViewController
        detailViewController?.seletedUserId = userArray[indexPath.row].id!
        self.navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    static func initViewController(viewControllerIdentifier: String, fromStoryboard storyboardName: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: viewControllerIdentifier)
    }
}

extension LauncherViewController: sortingDelegate{
    
    // Sorting delegate method
    func performsorting(order: String) {
        if order == "Ascending" {
            userArray = userArray.sorted(by: { $0.name! < $1.name!})
        }else if order == "Descending"{
            userArray = userArray.sorted(by: { $0.name! > $1.name!})
        }else{
            userArray = launcherViewModel.launcherResponse!.results
        }
        launcherTableView.reloadData()
    }
}
