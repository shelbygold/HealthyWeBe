//
//  CreateProfileViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addProfilePhotoButtonTapped(_ sender: Any) {
    AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        
        AttachmentHandler.shared.authorisationStatus(attachmentTypeEnum: .camera, vc: self)
            AttachmentHandler.shared.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self)
    }
    
    @IBAction func createUserButtonTapped(_ sender: Any) {
        
        
    }
    
}
