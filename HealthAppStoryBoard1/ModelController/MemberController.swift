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
    
    func createMemberFrom(member: Member) {
        let documentRef = dbRef.document()
    
        let dict = member.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }
    }
    
//    func createUSer(userFirstName:String, userLastName: String, userImage: UIImage, userBio: String, userEmail: String, userPassword: String){
//
//
//    }
    func fetchMemberFrom(Authorized: User, completion: @escaping (Member?, Error?) -> Void){
        dbRef.document(Authorized.uid).getDocument { (snapShot, error) in
            if let error = error{
                completion(nil, error)
                return
            }
            guard let snap = snapShot else {return}
            let newMember = Member.init(docSnapshot: snap)
            completion(newMember, nil)
        }
    }
}
