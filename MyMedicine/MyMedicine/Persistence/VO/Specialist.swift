//
//  Specialist.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/26/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class Specialist: NSManagedObject {

    @NSManaged var descriptionTxt: String
    @NSManaged var name: String
    @NSManaged var symptoms: NSSet
    @NSManaged var registries: NSOrderedSet
    
    
    /// The designated initializer
    convenience init()
    {
        // get context
        let context : NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription : NSEntityDescription? = NSEntityDescription.entityForName("Specialist", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
    
    
    // MARK: auxiliar functions for :N relationships
    
    func addSymptomObject(obj : Symptom) {
        var symptoms = self.mutableSetValueForKey("symptoms")
        symptoms.addObject(obj)
    }
    
    func removeSymptomObject(obj : Symptom) {
        var symptoms = self.mutableSetValueForKey("symptoms")
        symptoms.removeObject(obj)
    }
}
