//
//  GroupProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit
import FirebaseStorage

class GroupProfileViewController: UIViewController {

    @IBOutlet weak var groupProfileImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var totalGroupPoints: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var sloganLabel: UIStackView!
    
    let groupImageFileName =
        GroupController.shared.dbRef.document().documentID
    
    
    var groupImageRef: StorageReference {
        return Storage.storage().reference().child("groupImages")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

    }
    
    func downloadImage(){
        let downloadImageRef = groupImageRef.child(groupImageFileName)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                self.groupProfileImageView.image = image
            }
        }
        downloadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO more progress")
        }
        downloadTask.resume()
    }
    
    @IBAction func groupTabButtons(_ sender: Any) {
    }
    
}
