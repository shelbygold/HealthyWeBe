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
        guard let member = MemberController.shared.currentUser else {print("error with member"); return}
        let userRef = member.memberRef
        
        
        GroupController.shared.createGroup(groupName: groupName, groupimage: groupPic, groupSlogan: groupslogan, groupOwner: userRef, userRef: [userRef]) { (success) in
            let dispatchGroup = DispatchGroup()
            if success {
                dispatchGroup.enter()
                
                
                
                
                let uploadGroupImageRef = self.groupImageRef.child(self.groupImageFileName)
                
                guard let imageData = UIImage.pngData(groupPic)() else {return}
                
                let uploadTask = uploadGroupImageRef.putData(imageData, metadata: nil) { (storagemetaData, error) in
                    if let error = error{
                        print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                        return
                    }
                    uploadGroupImageRef.downloadURL(completion: { (urls, error) in
                        if let error = error{
                            print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                            return
                        }
                        guard let urls = urls,
                            let group = GroupController.shared.currentGroup else {return}
                        var grouURL = group.groupImageURL
                        grouURL = urls.absoluteString
                        
                        GroupController.shared.currentGroup?.groupImageURL = urls.absoluteString
                       
                    })
                    print(storagemetaData ?? "NO METADATA")
                }
                uploadTask.observe(.progress) { (snapShot) in
                    print(snapShot.progress ?? "NO PROGRESS")
                }
                uploadTask.resume()
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                // Go to Tab bar controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = viewController
            })
        }
    }
}
