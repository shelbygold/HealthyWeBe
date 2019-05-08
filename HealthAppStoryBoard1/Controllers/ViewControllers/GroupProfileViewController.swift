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
    @IBOutlet weak var tabSegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func groupTabButtons(_ sender: UISegmentedControl) {
        switch tabSegmentControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "Page1", sender: self)
        case 1:
            performSegue(withIdentifier: "Page2", sender: self)
        case 2:
            performSegue(withIdentifier: "Page3", sender: self)
        case 3:
            performSegue(withIdentifier: "Page4", sender: self)
        default:
            break;
        }
    }
    //MARK: hard code fix
    func downloadImage(group: Group) {
        let downloadURL = GroupController.shared.groups.remove(at: 0).groupImageURL
        let storageRef = Storage.storage().reference(forURL: downloadURL)
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
    }
}
