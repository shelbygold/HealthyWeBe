//
//  Task.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

enum TaskCategory: String {
    case fitness
    case mindfulness
    case sleep
    case nutrition
    
    var image: UIImage {
        switch self {
        case .fitness:
            return #imageLiteral(resourceName: "Running")
        case .mindfulness:
            return #imageLiteral(resourceName: "green")
        case .nutrition:
            return #imageLiteral(resourceName: "Pear")
        case .sleep:
            return #imageLiteral(resourceName: "weighIN")
        }
    }
    
    var backGroundColor: UIColor {
        switch self {
        case .fitness:
            return healthColors.myRed!
        case .mindfulness:
            return healthColors.myPurple!
        case .nutrition:
            return healthColors.myGreen!
        case .sleep:
            return healthColors.myOrange!
        }
    }
    var uncheckedTaskButton: UIImage {
        switch self {
        case .fitness:
            return #imageLiteral(resourceName: "redCircle")
        case .mindfulness:
            return #imageLiteral(resourceName: "purpleCircle")
        case .nutrition:
            return #imageLiteral(resourceName: "greenCircle")
        case .sleep:
            return #imageLiteral(resourceName: "orangeCircle")
        }
    }
    var checkedTaskButton: UIImage {
        switch self {
        case .fitness:
            return #imageLiteral(resourceName: "redCircleChecked")
        case .mindfulness:
            return #imageLiteral(resourceName: "purpleCircleChecked")
        case .nutrition:
            return #imageLiteral(resourceName: "greenCircleChecked")
        case .sleep:
            return #imageLiteral(resourceName: "orangeCircleChecked")
        }
    }
}

class Task {
    
    var taskTitle: String
    var taskType: String
    var taskPoints: Int
    var taskBeginDate: Date
    var taskEndDate: Date
    var taskGroupRef: DocumentReference
    var taskOwnerRef: DocumentReference
    var taskOwnerUUID: String?
    var taskRef: DocumentReference
    var taskUUID: String
    var isComplete: Bool
    
    
    init(taskTitle: String, taskType: String, taskPoints: Int, taskBeginDate: Date, taskEndDate: Date, taskUUID: String, taskGroupRef: DocumentReference, taskOwnerRef: DocumentReference,
         taskRef: DocumentReference, isComplete: Bool = false){
        
        self.taskTitle = taskTitle
        self.taskType = taskType
        self.taskPoints = taskPoints
        self.taskBeginDate = taskBeginDate
        self.taskEndDate = taskEndDate
        self.taskRef = taskRef
        self.taskGroupRef = taskGroupRef
        self.taskOwnerRef = taskOwnerRef
        self.taskUUID = taskUUID
        self.isComplete = isComplete
    }
    
    convenience init?(docSnapshot: DocumentSnapshot){
        
        let taskRefs = TaskController.shared.dbRef.document(docSnapshot.documentID)
        guard
            let dictionary = docSnapshot.data(),
            let title = dictionary["taskTitle"] as? String,
            let type = dictionary["taskType"] as? String,
            let points = dictionary["taskPoints"] as? Int,
            let begin = dictionary["taskBeginDate"] as? Timestamp,
            let end = dictionary["taskEndDate"] as? Timestamp,
            let taskUUID = dictionary["taskUUID"] as? String,
            let taskGroupRef = dictionary["taskGroupRef"] as? DocumentReference,
            let taskOwnerRef = dictionary["taskOwnerRef"] as? DocumentReference,
            let taskOwnerUUID = dictionary["taskOwnerUUID"] as? String,
            let isComplete = dictionary["isComplete"] as? Bool
            else {return nil}
        
        
        self.init(taskTitle: title, taskType: type, taskPoints: points, taskBeginDate: begin.dateValue(), taskEndDate: end.dateValue(), taskUUID: taskUUID, taskGroupRef: taskGroupRef, taskOwnerRef: taskOwnerRef,
                  taskRef: taskRefs, isComplete: isComplete)
        
    }
    convenience init?(dictionary: [String: Any]){
        
        
        guard let title = dictionary["taskTitle"] as? String,
            let type = dictionary["taskType"] as? String,
            let points = dictionary["taskPoints"] as? Int,
            let begin = dictionary["taskBeginDate"] as? Date,
            let end = dictionary["taskEndDate"] as? Date,
            let taskUUID = dictionary["taskUUID"] as? String,
            let taskGroupRef = dictionary["taskGroupRef"] as? DocumentReference,
            let taskOwnerRef = dictionary["taskOwnerRef"] as? DocumentReference,
            let taskRef = dictionary["taskRef"] as? DocumentReference,
            let isComplete = dictionary["isComplete"] as? Bool
            else {return nil}
        self.init(taskTitle: title, taskType: type, taskPoints: points, taskBeginDate: begin, taskEndDate: end, taskUUID: taskUUID, taskGroupRef: taskGroupRef, taskOwnerRef: taskOwnerRef,
                  taskRef: taskRef, isComplete: isComplete)
    }
    
    var asDict: [String:Any] {
        return ["taskType": taskType,
                "taskTitle": taskTitle,
                "taskUUID": taskUUID,
                "taskRef": taskRef,
                "taskOwnerRef": taskOwnerRef,
                "taskPoints": taskPoints,
                "taskGroupRef": taskGroupRef,
                "taskBeginDate": taskBeginDate,
                "taskOwnerUUID": taskOwnerRef.documentID,
                "taskEndDate": taskEndDate,
                "isComplete": isComplete]
        
    }
    func returnCategory ()-> TaskCategory {
        switch self.taskType {
        case "fitness":
            return .fitness
        case "mindfulness":
            return .mindfulness
        case "nutrition":
            return .nutrition
        case "sleep":
            return .sleep
        default:
            print("not a taskCategory")
            return .fitness
        }
    }
}

