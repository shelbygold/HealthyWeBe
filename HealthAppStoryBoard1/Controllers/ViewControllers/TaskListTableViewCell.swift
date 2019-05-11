//
//  TaskListTableViewCell.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/10/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var taskPointsLabel: UILabel!
    
     var delegate: buttonTableViewCellDelegate?
    
    var pointCount: Int?
    
    let member = MemberController.shared.currentMember
    
    
    var tasks: Task? {
        didSet{
            print("task was set")
            print("\(self.tasks?.taskPoints)")

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    @IBAction func taskButtonTapped(_ sender: UIButton) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    func updateCell(){
        guard let task = tasks else {return}
        taskTitleLabel.text = task.taskTitle
        dueDateLabel.text = task.taskEndDate.stringWith(dateStyle: .short, timeStyle: .short)
        taskPointsLabel.text = "\(task.taskPoints)"
    }
    
    fileprivate func updateButton(_ isComplete: Bool) {
        let addComplete = isComplete ? print("is complete") : print("is not complete")
        let checked = tasks?.returnCategory().checkedTaskButton
        let unchecked = tasks?.returnCategory().uncheckedTaskButton
        let imageName = isComplete ? checked : unchecked
        checkButton.setImage(imageName, for: .normal)
        guard let task = tasks else {return}
        let dueDate = isComplete ? "Completed" : "\(task.taskEndDate.stringWith(dateStyle: .short, timeStyle: .short))"
        dueDateLabel.text = dueDate
        guard let member = member else {return}

        MemberController.shared.addPoints(task, to: member) { (success) in
            if success {
                print(success)
                self.pointCount = MemberController.shared.currentMember?.userPoints
            }
        }
        
    }
    
}
extension TaskListTableViewCell {
    func update(withTask task: Task) {
        self.tasks = task
        updateCell()
        updateButton(task.isComplete)
    }
}

protocol buttonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: TaskListTableViewCell)
}
