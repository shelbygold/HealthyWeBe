//
//  Task.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class Task {
	
    let taskTitle: String
    let taskType: String
    
    let taskPoints: Int
    let taskBeginDate: Date
    let taskEndDate: Date
    let taskGroupID: DocumentReference
	let taskUUID: DocumentReference
    let UUID: String
    let group: Group
	
    init(taskTitle: String, taskType: String, taskPoints: Int, taskBeginDate: Date = Date(), taskEndDate: Date, taskUUID: DocumentReference, group: Group){
        
        self.taskTitle = taskTitle
        self.taskType = taskType
        self.taskPoints = taskPoints
        self.taskBeginDate = taskBeginDate
        self.taskEndDate = taskEndDate
        self.taskUUID = taskUUID
        self.taskGroupID = taskUUID
        self.group = group
        self.UUID = taskUUID.documentID
    }
	
    convenience init?(dictionary: [String: Any]){
        guard
        let title = dictionary["taskTitle"] as? String,
        let type = dictionary["taskType"] as? String,
        let points = dictionary["taskPoints"] as? Int,
        let begin = dictionary["taskBeginDate"] as? Date,
        let end = dictionary["taskEndDate"] as? Date,
        let taskUUID = dictionary["taskUUID"] as? DocumentReference,
        let group = dictionary["group"] as? Group
            else {return nil}
        self.init(taskTitle: title, taskType: type, taskPoints: points, taskBeginDate: begin, taskEndDate: end, taskUUID: taskUUID, group: group)
    }
    
    var asDict: [String:Any] {
        return ["taskType": taskType,
                "taskTitle": taskTitle,
                "taskUUID": UUID,
                "taskRef": taskUUID,
                "taskPoints": taskPoints,
                "groupID": taskGroupID,
                "taskBeginDate": taskBeginDate,
                "taskEndDate": taskEndDate,
                "group": group]
        
    }
}

