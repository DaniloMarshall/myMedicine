//
//  Medicine.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/27/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

enum TypeMedicine : Int16 {
    case registered = 0
    case generic = 1
    case homeopathic = 2
    case phytotherapic = 3
}

class Medicine: NSManagedObject {

    @NSManaged var adverseEffects: String
    @NSManaged var contraindication: String
    @NSManaged var descriptionSummary: String
    @NSManaged var informationLeaflet: NSData
    @NSManaged var name: String
    @NSManaged var photo: NSData
    @NSManaged var posology: String
    @NSManaged var type: Int16
    @NSManaged var registries: NSOrderedSet
    @NSManaged var relatedMeds: NSSet
    
    // Implementing accessors for enum types
    var typeEnum : TypeMedicine {
        get { return TypeMedicine(rawValue: self.type) ?? .generic }
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
    
    // MARK: auxiliar functions for :N relationships
    
    func addMedicineObject(obj : Medicine) {
        var relatedMeds = self.mutableSetValueForKey("relatedMeds")
        relatedMeds.addObject(obj)
    }
    
    func removeMedicineObject(obj : Medicine) {
        var relatedMeds = self.mutableSetValueForKey("relatedMeds")
        relatedMeds.removeObject(obj)
    }
}
