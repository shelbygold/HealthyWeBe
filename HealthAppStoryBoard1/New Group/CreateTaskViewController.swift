//
//  CreateTaskViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit


class CreateTaskViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var taskTypeLabel: UILabel!
    @IBOutlet weak var addTaskField: UITextField!
    @IBOutlet weak var beginDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    let beginDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    var taskType: String!
    var points: Int = 0
    
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTypeLabel.text = taskType
        setTaskImage(taskType: taskType)
        beginDateTextField.inputView = beginDatePicker
        endDateTextField.inputView = endDatePicker
        beginDatePicker.addTarget(self, action: #selector(setDateTextField(_:)), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(setDateTextField(_:)), for: .valueChanged)
    }
    
    func getDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: string)
    }
    
    @objc func setDateTextField(_ sender: UIDatePicker) {
        switch sender {
        case beginDatePicker:
            beginDateTextField.text = sender.date.stringWith(dateStyle: .short, timeStyle: .short)
        case endDatePicker:
            endDateTextField.text = sender.date.stringWith(dateStyle: .short, timeStyle: .short)
        default:
            print("Something went wrong")
        }
    }
    
    func setTaskImage(taskType: String){
        if taskType == "fitness"{
            taskImageView.image = #imageLiteral(resourceName: "ShadRunner")
            taskImageView.backgroundColor = healthColors.myRed
        } else if taskType == "mindfullness" {
            taskImageView.image = #imageLiteral(resourceName: "shadedMeditation")
            taskImageView.backgroundColor = healthColors.myPurple
        } else if taskType == "nutrition" {
            taskImageView.image = #imageLiteral(resourceName: "Eaten Pear")
            taskImageView.backgroundColor = healthColors.myGreen
        } else if taskType == "sleep" {
            taskImageView.image = #imageLiteral(resourceName: "weighIN")
            taskImageView.backgroundColor = healthColors.myOrange
        }
    }
    
    
    @IBAction func beginTextField(_ sender: UITextField) {
        beginDateTextField.text = beginDatePicker.date.stringWith(dateStyle: .short, timeStyle: .short)
    }
    @IBAction func endDateTextField(_ sender: UITextField) {
        
    }
    
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 220, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .dateAndTime
    }
    
    @IBAction func dailyButtonTapped(_ sender: Any) {
        //Repeat Task Daily
    }
    @IBAction func weeklyButtonTapped(_ sender: Any) {
        //Repeat Task Weekly
    }
    @IBAction func oneTimeButtonTapped(_ sender: Any) {
        //Delete task after the first time finished
    }
    @IBAction func upButtonTapped(_ sender: Any) {
        //increase Point Count
        points += 1
        pointsLabel.text = "\(points)"
    }
    @IBAction func downButtonTapped(_ sender: Any) {
        //Decrease Point Count
        points -= 1
        pointsLabel.text = "\(points)"
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let taskImage = taskImageView.image,
            let taskType = taskTypeLabel.text,
            let addText = addTaskField.text,
            let beginDate = beginDateTextField.text,
            let endDate = endDateTextField.text,
            let beginD = getDate(string: beginDate),
            let endD = getDate(string: endDate) else {return}
        
        
        guard let group = GroupController.shared.currentGroup else {print("errorwith group"); return}
        let groupRef = group.groupUUID
        
        TaskController.shared.createTask(title: addText, image: taskImage, type: taskType, points: points, beginDate: beginD, endDate: endD, group: group, groupRef: groupRef)
    }
    
        
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let viewcontroller = GroupTaskTableViewController.init()
        navigationController?.popToViewController(viewcontroller, animated: true)
    }
    
    
    
    
}

