//
//  SymptomDAO.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class SymptomDAO {
    /**
    Used to find a Symptom Data using it's name
    
    :param: name    String with name of symptom
    
    :returns: array with all symptoms found with given name
    */
    static func findByName(name: String) -> [Symptom]
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Symptom")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Symptom] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Symptom]
        
        return results
    }
    
    /**
    Used to find the first Symptom Data using it's name
    
    :param: name    String with name of symptom
    
    :returns: first symptom found with given name
    */
    static func findFirstByName(name: String) -> Symptom?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Symptom")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Symptom] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Symptom]
        
        return results[0]
    }
    
    /**
    Used to insert a symptom in the Database
    
    :param: objectToBeInserted  Object that will be inserted and must be of the type Symptom
    
    :returns: nil
    */
    static func insert(objectToBeInserted : Symptom)
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
    Used to delete a symptom in the Database
    
    :param: objectToBeDeleted  Object that will be deleted and must be of the type Symptom
    
    :returns: nil
    */
    static func delete(objectToBeDeleted : Symptom)
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
    Used to get a list of Symptoms Data
    
    :param: nil
    
    :returns: array of Symptom
    */
    static func getSymptomsList() -> [Symptom] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Symptom")
        
        // assign predicate
        // TODO: Adjust predicate
        //request.predicate = NSPredicate(format: "duration >= %ld", 0)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Symptom] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Symptom]
        
        return results
    }
}
