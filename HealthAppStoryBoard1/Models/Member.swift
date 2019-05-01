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
    var username: String
    var useremail: String
    var userPassword: String
    var userBio: String
    var userPoints: Int
    var userProfilePic: String
    var userUUID: DocumentReference
    var groupsRef: [DocumentReference]
    var myGroups: [Group]
    let UUID: String
    
    init(userName:String, userEmail:String, userPassword: String, userBio: String, userPoints: Int, userPic: String, userDoc: DocumentReference, groups: [DocumentReference], myGroups: [Group]) {
    
        self.groupsRef = groups
        self.useremail = userEmail
        self.userPassword = userPassword
        self.username = userName
        self.userBio = userBio
        self.userPoints = userPoints
        self.userProfilePic = userPic
        self.userUUID = userDoc
        self.UUID = userUUID.documentID
        self.myGroups = myGroups
    }
    
    convenience init?(dictionary: [String: Any]){
        guard
            let memberName = dictionary["memberName"] as? String,
            let memberPassword = dictionary["memberPassword"] as? String,
            let groupRef = dictionary["groupRef"] as? [DocumentReference],
            let memberEmail = dictionary["memberEmail"] as? String,
            let profilePic = dictionary["profilePic"] as? String,
            let memberPoints = dictionary["memberPoints"] as? Int,
            let bio = dictionary["memberBio"] as? String,
            let userUUID = dictionary["userUUID"] as? DocumentReference,
            let myGroups = dictionary["myGroups"] as? [Group]
            else {return nil}
        self.init(userName:memberName, userEmail:memberEmail, userPassword: memberPassword, userBio: bio, userPoints: memberPoints, userPic: profilePic, userDoc: userUUID, groups: groupRef, myGroups: myGroups)
        
    }
    
    var asDict: [String:Any] {
        return ["bio": userBio,
                "email": useremail,
                "name": username,
                "password": userPassword,
                "points": userPoints,
                "profilePic": userProfilePic,
                "userUUID": userUUID,
                "UUID": UUID,
                "myGroups": myGroups,
                "groups": groupsRef]
    }
}
