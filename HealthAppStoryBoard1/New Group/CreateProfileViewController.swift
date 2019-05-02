//
//  CreateProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

import FirebaseStorage

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicImageView.border()
        self.profilePicImageView.addShadowImage(8, shadowOpacity: 8)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addProfilePhotoButtonTapped(_ sender: Any) {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (imagePicked) in
            
            
            self.profilePicImageView.circleRadius()
            self.profilePicImageView.image = imagePicked
            self.profilePicImageView.addShadowImage(8, shadowOpacity: 8)
        }
    }
    
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
        let firstName = firstNameTextField.text,
        let lastName = lastNameTextField.text,
        let bio = bioTextField.text,
        let myPic = profilePicImageView.image else {return}
        
      
    
//        let storageRef = Storage.storage().reference()
//
//        let uploadData = UIImage.pngData(self.profilePicImageView.image!)()
//        guard let data = uploadData else {return}
//        storageRef.putData(data, metadata: nil, completion: { (metaData, error) in
//            if let error = error{
//                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
//                return
//            }
//            print(metaData)
//        })
        
        
        UserAuthenticationController.shared.createNewUser(email: email, password: password) { (User, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            guard let user = User else {return}
            
            let uuid = user.uid
            let member = Member(userFirstName: firstName, userLastName: lastName, userEmail: email, userPassword: password, userBio: bio, userPic: myPic, userUUID: uuid)
            MemberController.shared.createMemberFrom(member: member)
            
            
            
            
            
        MemberController.shared.fetchMemberFrom(Authorized: user, completion: { (member, error) in
                if let error = error{
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    return
                }
                guard let member = member else {return}
                GroupController.shared.fetchGroupsFor(user: member, completion: { (groups) in
                    let dispatchGroup = DispatchGroup()
                    groups.forEach({ (group) in
                        dispatchGroup.enter()
                        TaskController.shared.fetchTasksFor(group: group, completion: { (success) in
                            if success {
                                dispatchGroup.leave()
                            }
                        })
                    })
                    dispatchGroup.notify(queue: .main, execute: {
                        // Go to Tab bar controller
                        let storyboard = UIStoryboard(name: "MainStoryBoard", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = viewController
                    })
                })
            })
        }
            
        }
    }

