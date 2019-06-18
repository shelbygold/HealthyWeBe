//
//  GroupsTableViewCell.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/8/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var taskNumberLabel: UILabel!
    @IBOutlet weak var groupnameLabel: UILabel!
    
    var groupLanded: Group?
    
    func updateCell(with group: Group){
        groupLanded = group
        updateViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews(){
        guard let group = groupLanded else {return}
        DownloadImages.shared.downloadGroupImage(group: group) { (image) in
            self.groupImageView.image = image
        }
        taskNumberLabel.text = "\(group.tasks.count)"
        groupnameLabel.text = group.groupName
    }
    

}

