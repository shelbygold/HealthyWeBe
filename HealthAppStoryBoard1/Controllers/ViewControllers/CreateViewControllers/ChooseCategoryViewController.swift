//
//  ChooseCategoryViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segueOver(type: TaskCategory){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "taskCreate") as? CreateTaskViewController
            viewController?.taskCategory = type
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = viewController
    }
    
    @IBAction func categoryTapped(_ sender: UIButton) {
        guard let restorationID = sender.restorationIdentifier,
            let category = TaskCategory(rawValue: restorationID)
            else { return }
        segueOver(type: category)
    }
    
    @IBAction func inviteFriendsButtonTapped(_ sender: Any) {
    }
    
}
