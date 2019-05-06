//
//  DashboardViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

	@IBOutlet weak var taskCollectionView: UICollectionView!
	
	var tasks: [FakeTask] = [
		FakeTask(taskTitle: "Meditate a lot", type: .mindfulness),
		FakeTask(taskTitle: "Stairmaster 500000", type: .fitness)
	]
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCollectionViewCell
		cell.layer.cornerRadius = 15
		cell.layer.shadowColor = UIColor.black.cgColor
		cell.layer.shadowOpacity = 0.1
		cell.layer.shadowOffset = CGSize(width: 0, height: 5)
		cell.layer.shadowRadius = 5
		cell.task = tasks[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.bounds.width * 0.95, height: collectionView.bounds.height * 0.9)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return self.view.bounds.width * 0.05
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: self.view.bounds.width * 0.025, bottom: 0, right: self.view.bounds.width * 0.025)
	}
}

class FakeTask {
	
	enum TaskType {
		case mindfulness
		case fitness
	}
	
	var taskTitle: String
	var type: FakeTask.TaskType
	
	init(taskTitle: String, type: FakeTask.TaskType) {
		self.taskTitle = taskTitle
		self.type = type
	}
}
