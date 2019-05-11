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
    @IBOutlet weak var totalGroupPoints: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var tabSegmentControl: UISegmentedControl!
    
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let group = group else {return}
        
        DownloadImages.shared.downloadGroupImage(group: group) { (image) in
            let image = image
            self.groupProfileImageView.image = image
        }
        numberOfMembersLabel.text = "\(group.userRef.count)"
        sloganLabel.text = group.groupSlogan
        
    }
	
    @IBAction func groupTabButtons(_ sender: UISegmentedControl) {
        switch tabSegmentControl.selectedSegmentIndex {
        case 0:
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "Page1" {
                    let destinVC = segue.destination as? CreateTaskViewController
                    destinVC?.group = self.group
                }
            }
           
        case 1:
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "Page2" {
                    let destinVC = segue.destination as? CreateTaskViewController
                    destinVC?.group = self.group
                }
            }
        case 2:
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "Page3" {
                    let destinVC = segue.destination as? CreateTaskViewController
                    destinVC?.group = self.group
                }
            }
        case 3:
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "Page4" {
                    let destinVC = segue.destination as? CreateTaskViewController
                    destinVC?.group = self.group
                }
            }
        default:
            break;
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageView" {
            let destinVC = segue.destination as? PageViewController
            destinVC?.group = self.group
        }
    }
}
