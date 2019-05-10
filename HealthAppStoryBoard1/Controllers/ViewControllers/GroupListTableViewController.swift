//
//  GroupListTableViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/7/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class GroupListTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    let groupCount = GroupController.shared.groups.count
    // MARK: - Table view data source
    let groups = GroupController.shared.groups
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupCount + 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if groupCount == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "createCells", for: indexPath) as! CreateNewGroupTableViewCell
            return cell
        } else {
            let group = groups[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCells", for: indexPath) as! GroupsTableViewCell
            cell.updateCell(with: group)
            return cell
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupDetailView" , let indexPath = tableView.indexPathForSelectedRow {
            let group = groups[indexPath.row]
            let detailVC = segue.destination as? GroupProfileViewController
            detailVC?.group = group
        }
    }
    
    
}
