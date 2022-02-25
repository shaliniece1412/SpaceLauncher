//
//  SortingDropDownViewController.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import UIKit

class SortingDropDownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var sortingTableView: UITableView!
    var delegate: sortingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortingDropDownViewController", for: indexPath)
        if indexPath.row == 0{
            cell.textLabel?.text = "Ascending"
        }else if indexPath.row == 1{
            cell.textLabel?.text = "Descending"
        }else{
            cell.textLabel?.text = "None"
        }
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        if indexPath.row == 0{
            delegate?.performsorting(order: "Ascending")
        }else if indexPath.row == 1{
            delegate?.performsorting(order: "Descending")
        }else{
            delegate?.performsorting(order: "None")
        }
    }
    
}
