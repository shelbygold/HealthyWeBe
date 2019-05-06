//
//  LoginViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        UserAuthenticationController.shared.signinUser(email: email, password: password) { (user, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                self.presentLoginAlert(errorMessage: error)
                return
            }
            guard let user = user else {return}
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
