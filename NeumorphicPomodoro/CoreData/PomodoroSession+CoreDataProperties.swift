//
//  PomodoroSession+CoreDataProperties.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 11/4/22.
//
//

import Foundation
import CoreData


extension PomodoroSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PomodoroSession> {
        return NSFetchRequest<PomodoroSession>(entityName: "PomodoroSession")
    }

    @NSManaged public var numberOfPomodoros: Int16
    @NSManaged public var numberOfRests: Int16
    @NSManaged public var date: Date?
    @NSManaged public var task: String?
    @NSManaged public var type: String?
    @NSManaged public var totalTime: Int32
    @NSManaged public var pomodoroLength: Int16
    @NSManaged public var restLenght: Int16
    @NSManaged public var restCadence: Int16
    @NSManaged public var longRestLength: Int16
    
    var unwrappedTask : String {
        return task ?? ""
    }
    
    var unwrappedType : String {
        return type ?? ""
    }

}

extension PomodoroSession : Identifiable {

}
