//
//  Contact.swift
//  HealthAppStoryBoard1
//
//  Created by Sam Wayne on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class Contact {
    let name: String
    let phoneNum: String
//    let isInvited: Bool
//    let photo: UIImage?
    
    init(name: String, phoneNum: String /* isInvited: Bool, photo: UIImage*/) {
        self.name = name
        self.phoneNum = phoneNum
//        self.isInvited = isInvited
//        self.photo = photo
    }
}

/* The current state of this is absolute bare minimum. I plan on implementing photos and checking whether the contact is already invited or not soon. */
