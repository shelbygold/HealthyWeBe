//
//  CreateProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

import FirebaseStorage
import Firebase

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    
    let imageFileName = MemberController.shared.dbRef.document().documentID
    
    
    var imageRef: StorageReference {
    return Storage.storage().reference().child("profileImages")
    }
    
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
        UserAuthenticationController.shared.createNewUser(email: email, password: password) { (User, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                self.presentLoginAlert(errorMessage: error)
                return
            }
            guard let user = User else {return}
            
        
            
            let uuid = user.uid
            
            let docRef =
        MemberController.shared.dbRef.document(uuid)

            
            let member = Member(userFirstName: firstName, userLastName: lastName, userEmail: email, userPassword: password, userBio: bio, userPic: myPic, userUUID: uuid, memberRef: docRef)
            MemberController.shared.createMemberFrom(member: member, uuid: uuid)
            
            MemberController.shared.currentUser = member
            
            
            guard let image = self.profilePicImageView.image else {return}
            guard let imageData = UIImage.pngData(image)() else {return}
            
            let uploadImageRef = self.imageRef.child(self.imageFileName)
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil, completion: { (storageMetaData, error) in
                print("Upload task finished")
                if let error = error{
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    self.presentLoginAlert(errorMessage: error)
                    return
                }
                print(storageMetaData ?? "NO MetaData")
            })
            
            uploadTask.observe(.progress, handler: { (snapShot) in
                print(snapShot.progress ?? "No Progress")
            })
            
            uploadTask.resume()
            
        MemberController.shared.fetchMemberFrom(Authorized: user, completion: { (member, error) in
                if let error = error{
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    self.presentLoginAlert(errorMessage: error)
                    
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
    func presentLoginAlert(errorMessage: Error){
        let alertController = UIAlertController.init(title: "Something went wrong", message: errorMessage.localizedDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(dismiss)
    }
    }

