//
//  DownloadImages.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 5/8/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import FirebaseStorage

class DownloadImages {
    
    static let shared = DownloadImages()
    
    func downloadGroupImage(group: Group, completion: @escaping (UIImage) -> Void)  {
        let downloadURL = group.groupImageURL
        let storageRef = Storage.storage().reference(forURL: downloadURL)
        storageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                guard let image = UIImage(data: data) else {return}
               completion(image)
                
            }
        }
    }
    
    
}
