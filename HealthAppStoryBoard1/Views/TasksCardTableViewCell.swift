//
//  TasksCardTableViewCell.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/9/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class TasksCardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskCollectionView: UICollectionView!
    
    var group: Group?
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
