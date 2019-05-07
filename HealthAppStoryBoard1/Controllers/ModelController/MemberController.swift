//
//  UserController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase


class MemberController{
    
    static let shared = MemberController()
    private init (){}
    
    var currentUser: Member?
    
    var users: [Member] = []
    
    let dbRef = Firestore.firestore().collection("member")
    
    
    func createMemberFrom(member: Member, uuid: String) {
        let documentRef = dbRef.document(uuid)
        
        let dict = member.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            self.currentUser = member
        }
    }
    
    
    func fetchMemberFrom(Authorized: User, completion: @escaping (Member?, Error?) -> Void){
        dbRef.document(Authorized.uid).getDocument { (snapShot, error) in
            if let error = error{
                completion(nil, error)
                return
            }
            guard let snap = snapShot else {return}
            let newMember = Member.init(docSnapshot: snap)
            // Fetch Image for newMember
                //Assign the UIImage to newMember
            
            self.currentUser = newMember
            completion(newMember, nil)
        }
    }
    
    func addGroupToUser(group: Group, completion: @escaping (Bool) -> Void) {
        currentUser?.groupsRef.append(group.groupUUID)
        saveCurrentUserToFirestore(completion: completion)
    }
    
    func saveCurrentUserToFirestore(completion: @escaping (Bool) -> Void) {
        
        currentUser?.memberRef.setData(currentUser!.asDict, completion: { (error) in
            if let error = error {
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
            }
            completion(true)
        })
    }
}
