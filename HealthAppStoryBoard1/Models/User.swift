//
//  User.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation

struct User: Codable {
    let useremail: String
    let userPassword: String
    let userBio: String
    let userPoints: Int
    let userProfilePic: String
    let userGroups: String
    
    enum CodingKeys: String, CodingKey{
        case useremail = "email"
        case userPassword = "password"
        case userBio = "bio"
        case userPoints = "individualPoints"
        case userProfilePic = "profilePic"
    }
}
extension User {
    init?(dict: [String:Any]) {
        guard let email = dict["email"] as? String,
        let password = dict["password"] as? String,
        let bio = dict["bio"] as? String,
            let individualPoints = dict["points"] as? Int,
        let profilePic = dict["profilePic"] as? String else {return nil}
        
        self.useremail = email
        self.userPassword = password
        self.userBio = bio
        self.userPoints = individualPoints
        self.userProfilePic = profilePic
    }
    
    var asJSONDictionary: [String: Any] {
        return["email": self.useremail, "password": self.userPassword, "bio": self.userBio, "points": self.userPoints, "profilePic": self.userProfilePic]
    }
    
    var asData: Data? {
        return (try? JSONSerialization.data(withJSONObject: asJSONDictionary, options: .prettyPrinted))
    }
    
}
