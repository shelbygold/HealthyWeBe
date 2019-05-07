//
//  Group.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class Group{
    var groupName: String
    var groupSlogan: String
    var groupPoints: Int
    var groupImage: UIImage?

    var userRef: [DocumentReference]
    var groupUUID: DocumentReference
    var UUID: String
    var groupOwner: DocumentReference
    var taskRef: [DocumentReference?]
    var tasks: [Task]
    
    
    
    init(groupName: String, groupSlogan: String, groupPoints: Int = 0, groupImage: UIImage?, userRef: [DocumentReference], groupOwner: DocumentReference, groupUUID: DocumentReference, tasksRefs: [DocumentReference] = [], task: [Task] = []) {
        
        self.groupName = groupName
        self.groupSlogan = groupSlogan
        self.groupPoints = groupPoints
        self.groupImage = groupImage
        self.userRef = userRef
        self.groupOwner = groupOwner
        self.groupUUID = groupUUID
        self.taskRef = tasksRefs
        self.tasks = task
        self.UUID = groupUUID.documentID
        
        
    }
    
   convenience init?(dictionary: [String: Any] ) {
        guard
        let name = dictionary["groupName"] as? String,
        let slogan = dictionary["groupSlogan"] as? String,
        let points = dictionary["groupPoints"] as? Int,
        let userRef = dictionary["userRef"] as? [DocumentReference],
        let groupOwner = dictionary["groupOwner"] as? DocumentReference,
        let groupUUID = dictionary["groupUUID"] as? DocumentReference,
        let taskRef = dictionary["taskRef"] as? [DocumentReference],
        let tasks = dictionary["tasks"] as? [Task]
			else { print("Group init from dict failed. Missing data") ; return nil }
        self.init(groupName: name, groupSlogan: slogan, groupPoints: points, groupImage: nil, userRef: userRef, groupOwner: groupOwner, groupUUID: groupUUID, tasksRefs: taskRef , task: tasks)
    }
    
    var asDict: [String:Any] {
        return ["groupName" : groupName,
                "groupSlogan" : groupSlogan,
                "groupOwner": groupOwner,
                "groupPoints": groupPoints,
                "userRef": userRef,
                "groupUUID": groupUUID,
                "taskRef": taskRef,
                "tasks": tasks,
                "UUID": UUID]
        
    }
}
