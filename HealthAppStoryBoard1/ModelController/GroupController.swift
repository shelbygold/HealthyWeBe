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
    private init (){
//        fetchGroupsFor(user: UserController.shared.users.first!) { (groups) in
//            groups.forEach({ (group) in
//                TaskController.shared.fetchTasksFor(group: group, completion: <#T##<<error type>>#>)
//            })
//        }
    }
    
    var groups: [Group] = []
    
    let dbRef = Firestore.firestore().collection("group")
    
    func createGroup(groupName:String, groupimage:String, groupSlogan:String, groupOwner: DocumentReference, groupPoint: Int, groupTasks: [DocumentReference], groupUsers: [Member], userRef: [DocumentReference], task: [Task]) {
        
        let documentRef = dbRef.document()
        
        let newGroup = Group(groupName: groupName, groupSlogan: groupSlogan, groupPoints: groupPoint, groupImage: groupimage, groupUsers: groupUsers, userRef: userRef, groupOwner: groupOwner, groupUUID: documentRef, tasksRefs: groupTasks, task: task)
        
        let dict = newGroup.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }
    }
    func fetchGroupsFor(user: Member, completion: @escaping ([Group]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var returnGroups: [Group] = []
        user.groupsRef.forEach { (documentRef) in
            dispatchGroup.enter()
            documentRef.getDocument(completion: { (snapshot, error) in
                if let error = error {
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let dictionary = snapshot?.data() else { return }
                
                let newGroup = Group(dictionary: dictionary)
                
                user.myGroups.append(newGroup!)
                returnGroups.append(newGroup!)
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(returnGroups)
        }
    }
}
