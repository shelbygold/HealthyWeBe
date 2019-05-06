//
//  ContactController.swift
//  HealthAppStoryBoard1
//
//  Created by Sam Wayne on 5/1/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//
import Foundation
import Contacts

class ContactController {
    static let shared = ContactController()
    var contacts = [Contact]()
    
    func fetchContacts()->[Contact] {
        let contactStore = CNContactStore()
        // request access to contactbook
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if let error = error {
                // should be handle with an alert controller 
                print("locked out", error.localizedDescription)
                return
            }
            if success {
                print("access to contacts granted")
                let keys = [CNContactGivenNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                    try  contactStore.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        self.contacts.append(Contact(name: contact.givenName, phoneNum: "\(String(describing: contact.phoneNumbers.first))")
                        )})
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            else { print("access to contacts denied") }
        }
        return contacts
    }
}
