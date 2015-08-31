//
//  Registry.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/27/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

enum TypeRegistry : Int16 {
    case medicine = 0
    case specialist = 1
    case symptom = 2
    case unknown = -1
}

class Registry: NSManagedObject {

    @NSManaged var dateAdded: NSDate
    @NSManaged var dateChosen: NSDate
    @NSManaged var type: Int16
    @NSManaged var isDaily: Bool
    @NSManaged var isFixedPeriod: Bool
    @NSManaged var hasDaysOff: Bool
    @NSManaged var amountDaysOff: Int32
    @NSManaged var note: String
    @NSManaged var id: NSNumber
    @NSManaged var amountDaysOn: Int32
    @NSManaged var amountDaysPeriod: Int32
    @NSManaged var medicineValue: Medicine
    @NSManaged var specialistValue: Specialist
    @NSManaged var symptomValue: Symptom
    
    // Implementing accessors for enum types
    var typeEnum : TypeRegistry {
        get { return TypeRegistry(rawValue: self.type) ?? .medicine }
        set { self.type = newValue.rawValue }
    }
    
    /// The designated initializer
    convenience init()
    {
        // get context
        let context : NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription : NSEntityDescription? = NSEntityDescription.entityForName("Medicine", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
    
    // MARK: auxiliar functions for relationships
    
    func addMedicineObject(obj : Medicine) {
        var medicineValue = self.mutableSetValueForKey("medicineValue")
        medicineValue.addObject(obj)
    }
    
    func removeMedicineObject(obj : Medicine) {
        var medicineValue = self.mutableSetValueForKey("medicineValue")
        medicineValue.removeObject(obj)
    }
    
    func addSpecialistObject(obj : Medicine) {
        var specialistValue = self.mutableSetValueForKey("specialistValue")
        specialistValue.addObject(obj)
    }
    
    func removeSpecialistObject(obj : Medicine) {
        var specialistValue = self.mutableSetValueForKey("specialistValue")
        specialistValue.removeObject(obj)
    }
    
    func addSymptomObject(obj : Medicine) {
        var symptomValue = self.mutableSetValueForKey("symptomValue")
        symptomValue.addObject(obj)
    }
    
    func removeSymptomObject(obj : Medicine) {
        var symptomValue = self.mutableSetValueForKey("symptomValue")
        symptomValue.removeObject(obj)
    }

}
