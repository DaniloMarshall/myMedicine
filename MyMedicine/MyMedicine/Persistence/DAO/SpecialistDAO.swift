//
//  SpecialistDAO.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class SpecialistDAO {
    /**
    Used to find a Specialist Data using it's name
    
    :param: name    String with name of specialist
    
    :returns: array with all specialists found with given name
    */
    static func findByName(name: String) -> [Specialist]
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Specialist")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Specialist] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Specialist]
        
        return results
    }
    
    /**
    Used to find the first Specialist Data using it's name
    
    :param: name    String with name of specialist
    
    :returns: first specialist found with given name
    */
    static func findFirstByName(name: String) -> Specialist?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Specialist")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Specialist] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Specialist]
        
        return results[0]
    }
    
    /**
    Used to insert a specialist in the Database
    
    :param: objectToBeInserted  Object that will be inserted and must be of the type Specialist
    
    :returns: nil
    */
    static func insert(objectToBeInserted : Specialist)
    {
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        saveContext()
    }
    
    static func saveContext()
    {
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
    Used to delete a specialist in the Database
    
    :param: objectToBeDeleted  Object that will be deleted and must be of the type Specialist
    
    :returns: nil
    */
    static func delete(objectToBeDeleted : Specialist)
    {
        // remove object from context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        
        saveContext()
    }
    
    
    /**
    Used to get a list of Specialists Data
    
    :param: nil
    
    :returns: array of Specialist
    */
    static func getSpecialistsList() -> [Specialist] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Specialist")
        
        // assign predicate
        // TODO: Adjust predicate
        //request.predicate = NSPredicate(format: "duration >= %ld", 0)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Specialist] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Specialist]
        
        return results
    }
}