//
//  Symptom.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

@objc class Symptom: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var descriptionTxt: String
    @NSManaged var specialists: NSSet

    /// The designated initializer
    convenience init()
    {
        // get context
        let context : NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription : NSEntityDescription? = NSEntityDescription.entityForName("Symptom", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
    
    
    // MARK: auxiliar functions for :N relationships
    
    func addSpecialistObject(obj : Specialist) {
        var specialists = self.mutableSetValueForKey("specialists")
        specialists.addObject(obj)
    }
    
    func removeSpecialistObject(obj : Specialist) {
        var specialists = self.mutableSetValueForKey("specialists")
        specialists.removeObject(obj)
    }
}
