//
//  TaskListTableViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/8/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, buttonTableViewCellDelegate {
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    static let shared = TaskListTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        pointsLabel.text = "\(MemberController.shared.currentMember?.userPoints ?? 0) pts"
        
        designNavBar()
    }
    
    func designNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
   
        
    }
    
    func buttonCellButtonTapped(_ sender: TaskListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let task = GroupController.shared.groups[indexPath.section].tasks[indexPath.row]
        TaskController.shared.taskIsComplete(task: task) { (success) in
            if success{
                print("success")
            }
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return GroupController.shared.groups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupController.shared.groups[section].tasks.count
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.sizeToFit()
        headerView.backgroundColor = .white
        let borderTop = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 1))
        borderTop.backgroundColor = healthColors.myBlack
        headerView.addSubview(borderTop)
        
        let borderBottom = UIView(frame: CGRect(x: 0, y: 40, width: tableView.bounds.size.width, height: 1))
        borderBottom.backgroundColor = healthColors.myBlack
        headerView.addSubview(borderBottom)
        
        let label = UILabel(frame: CGRect(x: 15, y: 9, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let group = GroupController.shared.groups
        label.text = group[section].groupName
        label.textColor = healthColors.myBlack
        label.sizeToFit()
        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = CGFloat(integerLiteral: 40)
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskListTableViewCell
        let task = GroupController.shared.groups[indexPath.section].tasks[indexPath.row]
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }

 

}
