//
//  MedicineDAO.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class MedicineDAO {
    /**
    Used to find a Symptom Data using it's name
    
    :param: name    String with name of medicine
    
    :returns: array with all medicines found with given name
    */
    static func findByName(name: String) -> [Medicine]
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Medicine")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Medicine] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Medicine]
        
        return results
    }
    
    /**
    Used to find the first Medicine Data using it's name
    
    :param: name    String with name of medicine
    
    :returns: first medicine found with given name
    */
    static func findFirstByName(name: String) -> Medicine?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Medicine")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Medicine] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Medicine]
        
        return results[0]
    }
    
    /**
    Used to insert a medicine in the Database
    
    :param: objectToBeInserted  Object that will be inserted and must be of the type Medicine
    
    :returns: nil
    */
    static func insert(objectToBeInserted : Medicine)
    {
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        // save context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        if (error != nil)
        {
            // log error
            print(error)
        }
    }
    
    /**
    Used to delete a medicine in the Database
    
    :param: objectToBeDeleted  Object that will be deleted and must be of the type Medicine
    
    :returns: nil
    */
    static func delete(objectToBeDeleted : Medicine)
    {
        // remove object from context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        
        // log error
        if (error != nil)
        {
            // log error
            print(error)
        }
    }
    
    
    /**
    Used to get a list of Medicines Data
    
    :param: nil
    
    :returns: array of Symptom
    */
    static func getMedicinesList() -> [Medicine] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Medicine")
        
        // assign predicate
        // TODO: Adjust predicate
        //request.predicate = NSPredicate(format: "duration >= %ld", 0)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Medicine] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Medicine]
        
        return results
    }
}
