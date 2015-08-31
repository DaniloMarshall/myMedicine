//
//  RegistryDAO.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/27/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class RegistryDAO {
    
    // MARK: Private variables and methods
    
    private static var currentID : Int = 0
    
    /**
    Used to save context of Core Data
    
    :param: nil
    
    :return: nil
    */
    private static func saveContext()
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
    
    // MARK: Public methods
    
    /**
    Used to get the next ID to be used when creating a new Registry
    
    :param: nil
    
    :return: Int with ID to be used
    */
    static func reserveID() -> Int {
        var reservedID = currentID
        currentID++
        return reservedID
    }
    
    /**
    Used to find Registry Data using it's id
    
    :param: id          NSNumber with id of registry
    
    :returns: first registry found with given id (supposed to have only one)
    */
    static func findFirstById(id: NSNumber) -> Registry?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        request.predicate = NSPredicate(format: "id == %d", id)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        return results[0]
    }
    
    /**
    Used to insert a registry in the Database
    
    :param: objectToBeInserted  Object that will be inserted and must be of the type Registry
    
    :returns: nil
    */
    static func insert(objectToBeInserted : Registry)
    {
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        // save context
        saveContext()
    }
    
    /**
    Used to insert a medicine in a registry of the Database
    
    :param: id                  NSNumber with id of registry
    :param: objectToBeInserted  Object that will be inserted and must be of the type Medicine
    
    :returns: nil
    */
    static func insertMedicine(id: NSNumber, objectToBeInserted : Medicine)
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        request.predicate = NSPredicate(format: "id == %d", id)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        results[0].medicineValue = objectToBeInserted
        
        // save context
        saveContext()
    }
    
    /**
    Used to insert a symptom in a registry of the Database
    
    :param: id                  NSNumber with id of registry
    :param: objectToBeInserted  Object that will be inserted and must be of the type Symptom
    
    :returns: nil
    */
    static func insertSymptom(id: NSNumber, objectToBeInserted : Symptom)
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        request.predicate = NSPredicate(format: "id == %d", id)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        results[0].symptomValue = objectToBeInserted
        
        // save context
        saveContext()
    }
    
    /**
    Used to insert a specialist in a registry of the Database
    
    :param: id                  NSNumber with id of registry
    :param: objectToBeInserted  Object that will be inserted and must be of the type Specialist
    
    :returns: nil
    */
    static func insertSpecialist(id: NSNumber, objectToBeInserted : Specialist)
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        request.predicate = NSPredicate(format: "id == %d", id)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        results[0].specialistValue = objectToBeInserted
        
        // save context
        saveContext()
    }
    
    /**
    Used to delete a registry in the Database
    
    :param: objectToBeDeleted  Object that will be deleted and must be of the type Registry
    
    :returns: nil
    */
    static func delete(objectToBeDeleted : Registry)
    {
        // remove object from context
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        
        // save context
        saveContext()
    }
    
    
    /**
    Used to get a list of Registries Data
    
    :param: nil
    
    :returns: array of Registry
    */
    static func getRegistriesListOrderedByDateAdded() -> [Registry] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        return results
    }
    
    /**
    Used to get a list of Registries Data
    
    :param: nil
    
    :returns: array of Registry
    */
    static func getRegistriesListOrderedByDateChosen() -> [Registry] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        let sortDescriptor = NSSortDescriptor(key: "dateChosen", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        return results
    }
    /**
    Used to get a list of Registries data on a range of NSDate
    
    :param: startDate   NSDate with start date of search
    :param: endDate     NSDate with end date of search
    
    :returns: array of Registry
    */
    static func getOrderedRegistriesWithDateRange(startDate : NSDate, endDate: NSDate) -> [Registry] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Registry")
        
        // assign predicate
        let predicate = NSPredicate(format: "dateChosen >= %@ AND dateChosen <= %@", startDate,endDate)
        request.predicate = predicate
        
        // assign descriptor
        let sortDescriptor = NSSortDescriptor(key: "dateChosen", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Registry] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Registry]
        
        return results
    }
}
