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
		
	}
	
	var groups: [Group] = []
	
	let dbRef = Firestore.firestore().collection("group")
    
    func createGroupFrom(group: Group, uuid: String){

        let docRef = dbRef.document(uuid)
        let dict = group.asDict
        docRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            self.groups.append(group)
        }
    }
	
    func fetchGroups(for member: Member, completion: @escaping ([Group]?,Error?) -> Void) {
        dbRef.whereField("memberUUIDs", arrayContains: member.userUUID).getDocuments { [weak self] (snapshot, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion([], error)
                return
            }
            guard let snapshot = snapshot else {return}
            let groups = snapshot.documents.compactMap { Group(docSnapshot: $0)  }
            self?.groups = groups
            completion(self?.groups,nil)
        }
    }
    
    func add(_ task: Task, to group: Group, completion: @escaping (Bool) -> Void) {
        group.taskRef.append(task.taskRef)
        group.tasks.append(task)
        save(group, completion: completion)
    }
	
    func addURL(_ groupURL: URL, to group: Group, completion: @escaping (Bool) -> Void) {
        group.groupImageURL = groupURL.absoluteString
        save(group, completion: completion)
    }
	
    func save(_ group: Group, completion: @escaping (Bool) -> Void) {
        group.groupRef.setData(group.asDict, completion: { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            completion(true)
        })
    }
	
	func add(member: Member, toGroup group: String, completion: @escaping (Bool) -> Void) {
	}
	
	func fetchGroup(withID ID: String, completion: @escaping (Group?) -> Void) {
		
	}
}

