//
//  GroupProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class GroupProfileViewController: UIViewController {
    
    @IBOutlet weak var groupProfileImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var totalGroupPoints: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var sloganLabel: UIStackView!
    

    let currentGroup = GroupController.shared.currentGroup
    
    func findGroupImageFileName(group: Group) -> String{
        let groupRef = group.groupUUID.documentID
        
        return groupRef
    }
    
    
    var groupImageRef: StorageReference {
        return Storage.storage().reference().child("groupImages")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(group: currentGroup!)
    }
    
    
    
    func downloadImage(group: Group) {
        let downloadURL = GroupController.shared.currentGroup?.groupImageURL
        let storageRef = Storage.storage().reference(forURL: downloadURL!)
        
        storageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                self.groupProfileImageView.image = image
                
            }
        }
//        downloadImage.observe(.progress) { (snapshot) in
//            print(snapshot.progress ?? "NO more progress")
//        }
//
//        downloadImage.resume()
    }
    
    @IBAction func groupTabButtons(_ sender: Any) {
    }
    
}
