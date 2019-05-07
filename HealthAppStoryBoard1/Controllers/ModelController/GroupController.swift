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
	var currentGroup: Group?
	
	var groups: [Group] = []
	
	let dbRef = Firestore.firestore().collection("group")
	
	func createGroup(groupName:String, groupimage:UIImage, groupSlogan:String, groupOwner: DocumentReference, groupPoint: Int = 0, groupTasks: [DocumentReference] = [], userRef: [DocumentReference], task: [Task] = [], completion: @escaping (Bool) -> Void) {
		
		let documentRef = dbRef.document()
		
		let newGroup = Group(groupName: groupName, groupSlogan: groupSlogan, groupImage: groupimage, userRef: userRef, groupOwner: groupOwner, groupUUID: documentRef)
		
		let dict = newGroup.asDict
		documentRef.setData(dict) { (error) in
			if let error = error {
				print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
				return
			}
			MemberController.shared.addGroupToUser(group: newGroup, completion: completion)
			self.currentGroup = newGroup
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
				
				guard let dictionary = snapshot?.data() else { print("Fetched group does not have data") ; return }
				
				let newGroup = Group(dictionary: dictionary)
				
				guard newGroup != nil else { print("Group was optional") ; return }
				self.currentGroup = newGroup
				returnGroups.append(newGroup!)
				dispatchGroup.leave()
			})
		}
		dispatchGroup.notify(queue: .main) {
			completion(returnGroups)
		}
	}
}
