//
//  ProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/26/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        profilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        profilePicture.circleRadius()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    func circleRadius() {
//        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
//        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
        
    }
    func addCornerRadiusImage(_ radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    func addShadowImage(_ shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
    
}
