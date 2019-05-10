//
//  DashboardViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tasktableView: UITableView!
    
    var groups = GroupController.shared.groups
    
    var storedOffsets = [Int: CGFloat]()
	
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tasktableView.delegate = self
        tasktableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasktableView.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCells", for: indexPath)
       return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TasksCardTableViewCell else {return}
        
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        tableViewCell.groupl = groups[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 295
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TasksCardTableViewCell else {return}
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
	
}


