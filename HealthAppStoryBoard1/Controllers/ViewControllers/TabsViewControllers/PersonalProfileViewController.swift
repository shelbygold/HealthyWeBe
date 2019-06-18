//
//  PersonalProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit
import FirebaseStorage

class PersonalProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var numberofGroupsLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
guard let member = MemberController.shared.activeMember else {return}
        nameLabel.text = member.userFirstName
        bioLabel.text = member.userBio
        pointsLabel.text = "\(member.userPoints ?? 0)"
        numberofGroupsLabel.text = "\(member.groupsRef.count ?? 0)"
       profileImageView.addCornerRadiusImage(25)
        downloadImage(member: member)
    }
    
    func downloadImage(member: Member) {
        let downloadURL = member.userPicURL
        let storageRef = Storage.storage().reference(forURL: downloadURL)
        storageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            if let data = data {
                let image = UIImage(data: data)
               self.profileImageView.image = image
                
            }
        }
    }

   

}
