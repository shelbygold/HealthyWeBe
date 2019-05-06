//
//  Constants.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

struct  taskTypeConstants {
    static let fitnessTasks = "fitness"
    static let mindfullnessTask = "mindfullness"
    static let nutritionTask = "nutrition"
    static let sleepTask = "sleep"
}
struct healthColors {
    static let myGreen = UIColor.init(named: "HealthyGreen")
    static let myOrange = UIColor.init(named: "HealthyOrange")
    static let myPurple = UIColor.init(named: "HealthyPurple")
    static let myRed = UIColor.init(named: "HealthyRed")
    static let myBlack = UIColor.init(named: "HealthyBlack")
    static let myDarkGray = UIColor.init(named: "HealthyDarkGray")
    static let myGray = UIColor.init(named: "HealthyGray")
    static let myWhite = UIColor.white
}
struct  spacingConstants {
    static let outerSpacing: CGFloat = 16
    static let verticalSpacing: CGFloat = 8
}

extension UIView {
    func border(){
        self.layer.borderWidth = 2
        self.layer.borderColor = healthColors.myRed?.cgColor
    }
    
    func circleRadius() {
        self.layer.borderWidth = 3
        self.layer.masksToBounds = true
        self.layer.borderColor = healthColors.myGray?.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
    }
    func addCornerRadiusImage(_ radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    func addShadowImage(_ shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.shadowColor = healthColors.myGray?.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
    
}
extension Date {
    func stringWith(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
extension UIView {
    
    func presentLoginAlert(errorMessage: Error){
        let alertController = UIAlertController.init(title: "Something went wrong", message: errorMessage.localizedDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(dismiss)
    }
}
