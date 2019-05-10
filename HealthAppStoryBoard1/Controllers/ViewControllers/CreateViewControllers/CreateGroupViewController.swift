//
//  CreateGroupViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit
import FirebaseStorage

class CreateGroupViewController: UIViewController {
    
    
    static let shared = CreateGroupViewController()
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupProfileImageView: UIImageView!
    @IBOutlet weak var sloganTextField: UITextField!
    
    let groupImageFileName =
       GroupController.shared.dbRef.document().documentID
    
    var groupImageRef: StorageReference {
        return Storage.storage().reference().child("groupImages")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupProfileImageView.border()
        self.groupProfileImageView.addCornerRadiusImage(16)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = {
            (imagePicked) in
            self.groupProfileImageView.image = imagePicked
            self.groupProfileImageView.addShadowImage(8, shadowOpacity: 8)
            
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let groupName = groupNameTextField.text,
            let groupslogan = sloganTextField.text,
        let groupPic = groupProfileImageView.image else {return}
        guard let member = MemberController.shared.members else {return}
        let userRef = member.memberRef
       
        let groupUUID = GroupController.shared.dbRef.document().documentID
        let groupRef = GroupController.shared.dbRef.document()
        
        let imageLocation = Storage.storage().reference().child(self.groupImageFileName)
        
        guard let groupimageData = UIImage.pngData(groupPic)() else {return}
        
        let newGroup = Group(groupName: groupName, groupSlogan: groupslogan, groupImage: groupPic, userRef: [userRef], groupOwner: userRef, groupRef: groupRef, groupUUID: groupUUID)
        newGroup.memberUUIDs.append(member.userUUID)
        
        imageLocation.putData(groupimageData, metadata: nil) { (storageMetaData, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            imageLocation.downloadURL(completion: { (groupUrl, error) in
                if let error = error{
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    return
                }
                guard let groupURL = groupUrl
                    else {return}

                GroupController.shared.addURL(groupURL, to: newGroup, completion: { (success) in
                    if success {
                        // do something
                    }
                })
            })
        }

        
        MemberController.shared.addGroupToUser(group: newGroup) { (success) in
            print(success)
        }

        let dispatchGroup = DispatchGroup()
            dispatchGroup.notify(queue: .main, execute: {
                // Go to Tab bar controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = viewController
            })
    }
}
