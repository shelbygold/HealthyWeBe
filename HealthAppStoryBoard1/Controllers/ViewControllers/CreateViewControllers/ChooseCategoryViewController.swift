//
//  ChooseCategoryViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit
import FirebaseDynamicLinks

class ChooseCategoryViewController: UIViewController {

    var group: Group?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segueOver(type: TaskCategory){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "taskCreate") as? CreateTaskViewController
            viewController?.taskCategory = type
        viewController?.group = group
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
		// URL to pass back into app when opened
		guard let link = URL(string: "?groupId=\(group!.groupUUID)") else { print("URL creation failed") ; return }
		//http://www.therollingpineapple.com/
		// Firebase deep link domain
		let dynamicLinksDomainURIPrefix = "https://healthappstoryboard2.page.link"
		let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
		linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "myapps.HealthAppStoryBoard2")
		linkBuilder?.iOSParameters?.appStoreID = "1463225445"
		guard let longDynamicLink = linkBuilder?.url else { return }
		// Create message text to send & encode into url
		let body = "Hey, join my group '\(group?.groupName ?? "Untitled")' on Fit With Friends by clicking the link below:\n\(longDynamicLink)"
		guard let escapedBody = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { print("Encoding failed") ; return }
		guard let phoneUrl = URL(string: "sms:&body=\(escapedBody)") else { print("URL creation failed") ; return }
		// Open in iMessage
		UIApplication.shared.open(phoneUrl)
    }
}
