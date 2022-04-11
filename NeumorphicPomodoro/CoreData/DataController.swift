//
//  DataController.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 11/4/22.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    var container = NSPersistentContainer(name: "NeumorphicPomodoro")
    
    init () {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("There was an error loading CoreData, \(error.localizedDescription)")
            }
            
        }
    }
}
