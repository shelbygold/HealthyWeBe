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
	
	// MARK: - Params
	var task: FakeTask? {
		didSet {
			updateViews()
		}
	}
	
	// MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		seeAllButton.layer.cornerRadius = 10
	}
	
	// MARK: - Functions
	func updateViews() {
		guard let task = task else { return }
		taskNameLabel.text = task.taskTitle
		switch task.type {
		case .fitness:
			self.backgroundColor = healthColors.myRed
		case .mindfulness:
			self.backgroundColor = healthColors.myGreen
		}
	}
}
