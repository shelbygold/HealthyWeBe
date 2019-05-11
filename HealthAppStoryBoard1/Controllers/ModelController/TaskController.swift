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
    
    
let dbRef = Firestore.firestore().collection("task")
    
    func createTaskFrom(task: Task, uuid: String){
        let docRef = dbRef.document(uuid)
        
        let dict = task.asDict
        docRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
        }
    }
    
    func fetchTasks(for group: Group, completion: @escaping ([Task?], Error?) -> Void){
        dbRef.whereField("taskOwnerUUID", isEqualTo: group.groupUUID).getDocuments { (snapShot, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion([], error)
                return
            }
            guard let snapshot = snapShot else {return}
            group.tasks = snapshot.documents.compactMap {
                Task(docSnapshot: $0) }
            completion(group.tasks, nil)
        }
    }
    
    func taskIsComplete(task: Task, completion: @escaping (Bool)-> Void){
        task.isComplete = !task.isComplete
        save(task, completion: completion)
    }
    
    func add(_ groupRef: Group, to task: Task, completion: @escaping (Bool) -> Void) {
        task.taskGroupRef = groupRef.groupRef
        save(task, completion: completion)
    }
    
    
    
    func save(_ task: Task, completion: @escaping (Bool) -> Void) {
        
        task.taskRef.setData(task.asDict , completion: {
            (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error)")
                return
            }
            completion(true)
        })
        
    }
}
    
