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
    var groupImageURL: String
    var userRef: [DocumentReference]
    var memberUUIDs: [String] = []
    var groupRef: DocumentReference
    var groupUUID: String
    var groupOwner: DocumentReference
    var taskRef: [DocumentReference?]
    var tasks: [Task]
    
    
    
    
    init(groupName: String, groupSlogan: String, groupPoints: Int = 0, groupImage: UIImage?, userRef: [DocumentReference], groupOwner: DocumentReference, groupRef: DocumentReference, groupUUID: String, tasksRefs: [DocumentReference] = [], groupImageURL: String = "", tasks: [Task] = []) {
        
        self.groupName = groupName
        self.groupSlogan = groupSlogan
        self.groupPoints = groupPoints
        self.groupImage = groupImage
        self.groupImageURL = groupImageURL
        self.userRef = userRef
        self.groupOwner = groupOwner
        self.groupRef = groupRef
        self.taskRef = tasksRefs
        self.groupUUID = groupUUID
        self.tasks = tasks
    }
    
    convenience init?(docSnapshot: DocumentSnapshot ) {
        
        let grouRefs = GroupController.shared.dbRef.document(docSnapshot.documentID)
        guard
            let dictionary = docSnapshot.data(),
            let name = dictionary["groupName"] as? String,
            let slogan = dictionary["groupSlogan"] as? String,
            let points = dictionary["groupPoints"] as? Int,
           
            let userRef = dictionary["userRef"] as? [DocumentReference],
            let groupOwner = dictionary["groupOwner"] as? DocumentReference,
            let taskRef = dictionary["taskRef"] as? [DocumentReference],
            let groupImageURL = dictionary["groupImageURL"] as? String,
            let memberUUIDs = dictionary["memberUUIDs"] as? [String]
            else { return nil }
        
        let groupUUID = docSnapshot.documentID
        
       self.init(groupName: name, groupSlogan: slogan, groupPoints: points, groupImage: nil, userRef: userRef, groupOwner: groupOwner, groupRef: grouRefs, groupUUID: groupUUID, tasksRefs: taskRef, groupImageURL: groupImageURL)
        
    }
    
    var asDict: [String:Any] {
        return ["groupName" : groupName,
                "groupSlogan" : groupSlogan,
                "groupOwner": groupOwner,
                "groupPoints": groupPoints,
                "userRef": userRef,
                "groupRef": groupRef,
                "taskRef": taskRef,
                "UUID": groupUUID,
                "memberUUIDs": userRef.map { $0.documentID },
                "groupImageURL": groupImageURL]
        
    }
}
