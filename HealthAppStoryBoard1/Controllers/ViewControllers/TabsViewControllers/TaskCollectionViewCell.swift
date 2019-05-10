//
//  TaskCollectionViewCell.swift
//  HealthAppStoryBoard1
//
//  Created by Ethan John on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Outlets
	@IBOutlet weak var taskNameLabel: UILabel!
	@IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
   
	// MARK: - Params
    var tasks: Task? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        seeAllButton.layer.cornerRadius = 10
    }
    @IBAction func uncheckedBoxTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let task = tasks else {return}
        taskNameLabel.text = task.taskTitle
        pointsLabel.text = "\(task.taskPoints) pts"
        self.backgroundColor = task.returnCategory().backGroundColor
        typeImageView.image = task.returnCategory().image
    }
    
}
