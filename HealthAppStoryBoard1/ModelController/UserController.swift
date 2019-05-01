//
//  UserController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase


class UserController{
    
    static let shared = UserController()
    private init (){}
    
    var users: [User] = []
    
    let dbRef = Firestore.firestore().collection("user")
    
    func createUSer(userName:String, userImage:String, userBio: String, userEmail: String, userPassword: String, userPoints: Int, userUUID: DocumentReference, userGroups: [DocumentReference], groups: [Group]){
        
        let documentRef = dbRef.document()
        
        let newUser = User(userName: userName, userEmail: userEmail, userPassword: userPassword, userBio: userBio, userPoints: userPoints, userPic: userImage, userDoc: documentRef, groups: userGroups, myGroups: groups)
        
        let dict = newUser.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }
    }
}
