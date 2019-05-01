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
    
    var users: [Member] = []
    
    let dbRef = Firestore.firestore().collection("Member")
    
    func createUSer(userName:String, userImage:String, userBio: String, userEmail: String, userPassword: String, userPoints: Int, userUUID: DocumentReference, userGroups: [DocumentReference], groups: [Group]){
        
        let documentRef = dbRef.document()
        
        let newUser = Member(userName: userName, userEmail: userEmail, userPassword: userPassword, userBio: userBio, userPoints: userPoints, userPic: userImage, userDoc: documentRef, groups: userGroups, myGroups: groups)
        
        let dict = newUser.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }
    }
    func fetchMemberFrom(Authorized: User, completion: @escaping (Member?, Error?) -> Void){
        dbRef.document(Authorized.uid).getDocument { (snapShot, error) in
            if let error = error{
                completion(nil, error)
                return
            }
            guard let dictionary = snapShot?.data() else {return}
            let newMember = Member.init(dictionary: dictionary)
            completion(newMember, nil)
        }
    }
}
