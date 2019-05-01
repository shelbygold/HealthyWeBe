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
    
let dbRef = Firestore.firestore().collection("tasl")

    func createTask(title: String, image: String, type: String, points: Int, beginDate: Date, endDate: Date, group: Group) {
        
        let documentRef = dbRef.document()
        
        let newTask = Task(taskTitle: title, taskType: type, taskImage: image, taskPoints: points, taskBeginDate: beginDate, taskEndDate: endDate, taskUUID: documentRef, group: group)
        
        let dict = newTask.asDict
        documentRef.setData(dict) { (error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
        }

        
    }
    
//    //Read
//    func retieveTask(groupID: String){
//        let retrievedTasks = Firestore.firestore().collection("task")
//        
//        retrievedTasks.whereField("Task", isEqualTo: groupID).getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: ]\(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())" )
//                }
//            }
//        }
//    }
//    
//    func fetchDocuments(groupID: String){
//        let documents = Firestore.firestore().collection(groupID)
//        
//        documents.getDocuments() { (QuerySnapshot, err) in
//            if let err = err {
//                print("error getting documents: \(err)")
//            } else {
//                for document in QuerySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
    }
}
