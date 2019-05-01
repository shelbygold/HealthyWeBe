//
//  GroupController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class GroupController {
    
    static let shared = GroupController()
    private init (){}
    
    var groups: [Group] = []
    
    let dbRef = Firestore.firestore().collection("group")
    
    func createGroup(groupName:String, groupimage:String, groupSlogan:String, groupOwner: DocumentReference, groupPoint: Int, groupTasks: [DocumentReference], groupUsers: [User], userRef: [DocumentReference], task: [Task]) {
        
        let documentRef = dbRef.document()
        
        let newGroup = Group(groupName: groupName, groupSlogan: groupSlogan, groupPoints: groupPoint, groupImage: groupimage, groupUsers: groupUsers, userRef: userRef, groupOwner: groupOwner, groupUUID: documentRef, tasks: groupTasks, task: task)
        
        let dict = newGroup.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }

    }
}
