//
//  TasksCardTableViewCell.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/9/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class TasksCardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var taskCollectionView: UICollectionView!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    var groupl: Group?{
        didSet{
            print("group received. \(groupl). \(groupl?.tasks.count)")
            self.taskCollectionView.reloadData()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        groupNameLabel.text = groupl?.groupName
        taskCollectionView.delegate = self
        taskCollectionView.dataSource = self
        groupNameLabel.text = groupl?.groupName ?? "my Group name Here"
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.contentView.bounds.width * 0.827, height: 180)
        
        taskCollectionView.setCollectionViewLayout(layout, animated: false)
    }


    
    var collectionViewOffset: CGFloat {
        set { taskCollectionView.contentOffset.x = newValue }
        get { return taskCollectionView.contentOffset.x }
    }

    
    
    func collectionView(_ taskCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("task Count: \(groupl?.tasks.count)")
        return groupl?.tasks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("I WANNA BLOW UP")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCollectionViewCell
        cell.layer.cornerRadius = 15
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 5
        cell.tasks = groupl?.tasks[indexPath.row]
        print("Cell made! \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(taskCollectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:
            self.contentView.bounds.width * 0.95, height: collectionView.bounds.height * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.contentView.bounds.width * 0.05
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: self.contentView.bounds.width * 0.025, bottom: 0, right: self.contentView.bounds.width * 0.025)
    }
}
