//
//  HomePageViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/24/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var topPageController: UIPageControl!
    
    static let shared = HomePageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.topPageController.addShadow(8, shadowOpacity: 8)
        
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
    func addCornerRadius(_ radius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
    }
    func addShadow(_ shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
    
}
