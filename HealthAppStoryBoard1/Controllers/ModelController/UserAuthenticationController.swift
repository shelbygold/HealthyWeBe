//
//  UserAuthenticationController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/30/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class UserAuthenticationController {
    
    static let shared = UserAuthenticationController()
    private init(){}
    
    func createNewUser(email:String, password: String, completion: @escaping (User?, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResults, error) in
            if let error = error{
                completion(nil, error)
                return
            }

            guard let AuthDataResults = AuthDataResults else {return}
            let newMember = AuthDataResults.user
            completion(newMember, nil)
            return
        }
    }
    
    func signinUser(email: String, password: String, completion: @escaping (User?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authResults, error) in
            if let error = error{
                completion(nil, error)
                return
            }
            
            guard let AuthDataResults = authResults else {return}
            let newMember = AuthDataResults.user
            completion(newMember, nil)
            return
            
        }
    }
}

