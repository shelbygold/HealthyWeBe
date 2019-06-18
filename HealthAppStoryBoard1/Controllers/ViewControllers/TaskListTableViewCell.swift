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
        let imageName = isComplete ? "checkedRed" : "uncheckedRed"
        checkButton.setImage(UIImage(named: imageName), for: .normal)
        guard let task = tasks else {return}
        let dueDate = isComplete ? "Completed" : "\(task.taskEndDate.stringWith(dateStyle: .short, timeStyle: .short))"
        dueDateLabel.text = dueDate
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
