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

        // Do any additional setup after loading the view.
    }
    
    func segueOver(type: String){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.notify(queue: .main, execute: {
            // Go to Tab bar controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "taskCreate") as? CreateTaskViewController
            viewController?.taskType = type
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = viewController
            
        })
    }
    
    @IBAction func fitnessButtontapped(_ sender: Any) {
        segueOver(type: "fitness")
    }
    @IBAction func mindfullButtonTapped(_ sender: Any) {
       segueOver(type: "mindfullness")
    }
    @IBAction func nutritionButtonTapped(_ sender: Any) {
        segueOver(type: "nutrition")
    }
    @IBAction func sleepButtonTapped(_ sender: Any) {
       segueOver(type: "sleep")
    }
    
    @IBAction func inviteFriendsButtonTapped(_ sender: Any) {
    }
    
}
