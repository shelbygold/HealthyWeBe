//
//  TaskController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/29/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation
import Firebase

class TaskController {
    
    
    static let shared = TaskController()
    private init (){}
    
    var tasks: [Task] = []
    
let dbRef = Firestore.firestore().collection("task")

    func createTask(title: String, type: String, points: Int, beginDate: Date, endDate: Date, groupRef: DocumentReference) {
        
        let documentRef = dbRef.document()
        
        let newTask = Task(taskTitle: title, taskType: type, taskPoints: points, taskBeginDate: beginDate, taskEndDate: endDate, taskUUID: documentRef)
        
        let dict = newTask.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
        }
    }
    }
    func fetchTasksFor(group: Group, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        var returnTasks: [Task] = []
        group.taskRef.forEach { (documentRef) in
            dispatchGroup.enter()
            documentRef!.getDocument(completion: { (snapshot, error) in
                if let error = error {
                    print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let dictionary = snapshot?.data() else { return }
                
                let newTasks = Task(dictionary: dictionary)
                
                group.tasks.append(newTasks!)
                returnTasks.append(newTasks!)
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            group.tasks = returnTasks
            completion(true)
        }
    }
}
