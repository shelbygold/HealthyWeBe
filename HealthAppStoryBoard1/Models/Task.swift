//
//  Task.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation

struct Task: Codable {
    let taskTitle: String
    let taskType: String
    let taskImage: String
    let taskPoints: String
    let taskBeginDate: Date
    let taskEndDate: Date
}
