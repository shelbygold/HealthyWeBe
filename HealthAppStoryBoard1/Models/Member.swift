//
//  User.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class Member {
    var userFirstName: String
    var userLastName: String
    var useremail: String
    var userPassword: String
    var userBio: String
    var userPoints: Int
    var userProfilePic: UIImage?
    var userUUID: String
    var groupsRef: [DocumentReference]
    let memberRef: DocumentReference
    
    init(userFirstName:String, userLastName: String, userEmail:String, userPassword: String, userBio: String, userPoints: Int = 0, userPic: UIImage?, userUUID: String, memberRef: DocumentReference, groups: [DocumentReference] = []) {
        
        self.groupsRef = groups
        self.useremail = userEmail
        self.userPassword = userPassword
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userBio = userBio
        self.userPoints = userPoints
        self.userProfilePic = userPic
        self.userUUID = userUUID
        self.memberRef = memberRef
      
    }
    
    convenience init?(docSnapshot: DocumentSnapshot){
        
        let memberRef = MemberController.shared.dbRef.document(docSnapshot.documentID)
        
        guard
            let dictionary = docSnapshot.data(),
            let memberFirstName = dictionary["memberFirstName"] as? String,
            let memberLastName = dictionary["memberLastName"] as? String,
            let memberPassword = dictionary["memberPassword"] as? String,
//            let memberRef = dictionary["memberRef"] as? DocumentReference,
            let groupRef = dictionary["groupRef"] as? [DocumentReference],
            let memberEmail = dictionary["memberEmail"] as? String,
            let memberPoints = dictionary["memberPoints"] as? Int,
            let bio = dictionary["memberBio"] as? String,
            let userUUID = dictionary["userUUID"] as? String
        
            else {print("conenience Init"); return nil }
        self.init(userFirstName:memberFirstName, userLastName: memberLastName, userEmail: memberEmail, userPassword: memberPassword, userBio: bio, userPoints: memberPoints, userPic: nil, userUUID: userUUID, memberRef: memberRef, groups: groupRef)
        
       
        
    }
    
    var asDict: [String:Any] {
        return ["memberBio": userBio,
                "memberEmail": useremail,
                "memberFirstName": userFirstName,
                "memberLastName": userLastName,
                "memberPassword": userPassword,
                "memberPoints": userPoints,
//                "profilePic": userProfilePic,
                "userUUID": userUUID,
                "memberRef": memberRef as Any,
                "groupRef": groupsRef]
    }
}
