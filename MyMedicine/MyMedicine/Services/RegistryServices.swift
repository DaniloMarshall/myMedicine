//
//  RegistryServices.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/27/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class RegistryServices {
    // MARK: Registry Operations
    /**
    Used to add a registry to database
    
    :param: dateChosen          NSDate with date users choose to add the registry to
    :param: type                TypeRegistry with type of registry that is being stored
    :param: isDaily             Bool that marks if this is a daily registry or not (usually used for medicines)
    :param: isFixedPeriod       Bool that marks if this is a registry that should be marked for more than one consecutive day (usually used for medicines)
    :param: hasDaysOff          Bool that marks if it's a periodic regitry that has fixed amount of days without registry (usually used for medicines)
    :param: amountDaysOff       Int32 with number of days off
    :param: amountDaysOn        Int32 with number of days on
    :param: amountDaysPeriod    Int32 with number of days of the fixed period (use 0 if it has a period and it's not determined)
    :param: note                String with note from the user to the registry
    
    :returns: nil
    */
    static func createRegistry(dateChosen:NSDate, type:TypeRegistry, isDaily:Bool, isFixedPeriod:Bool, hasDaysOff:Bool, amountDaysOff:Int32, amountDaysOn:Int32, amountDaysPeriod:Int32, note:String)
    {
        var registry : Registry = Registry()
        registry.id = RegistryDAO.reserveID()
        registry.dateAdded = NSDate()
        registry.dateChosen = dateChosen
        registry.typeEnum = type
        registry.isDaily = isDaily
        registry.isFixedPeriod = isFixedPeriod
        registry.hasDaysOff = hasDaysOff
        registry.amountDaysOff = amountDaysOff
        registry.amountDaysOn = amountDaysOn
        registry.amountDaysPeriod = amountDaysPeriod
        registry.note = note
        
        // insert it
        RegistryDAO.insert(registry)
    }
    
    /**
    Used to add a symptom to a Registry
    
    :param: registryID      NSNumber with ID of the Registry that has a specific symptom
    :param: symptomName     String with Symptom name that will be added to the registry
    
    :returns: nil
    */
    static func addSymptom(registryID:NSNumber, symptomName:String)
    {
        RegistryDAO.insertSymptom(registryID, objectToBeInserted: SymptomDAO.findFirstByName(symptomName)!)
    }
    
    /**
    Used to add a specialist to a Registry
    
    :param: registryID      NSNumber with ID of the Registry that has a specific specialist
    :param: specialistName  String with Specialist name that will be added to the registry
    
    :returns: nil
    */
    static func addSpecialist(registryID:NSNumber, specialistName:String)
    {
        RegistryDAO.insertSpecialist(registryID, objectToBeInserted: SpecialistDAO.findFirstByName(specialistName)!)
    }
    
    /**
    Used to add a medicine to a Registry
    
    :param: registryID      NSNumber with ID of the Registry that has a specific medicine
    :param: medicineName    String with Medicine name that will be added to the registry
    
    :returns: nil
    */
    static func addMedicine(registryID:NSNumber, medicineName:String)
    {
        RegistryDAO.insertMedicine(registryID, objectToBeInserted: MedicineDAO.findFirstByName(medicineName)!)
    }
    
    /**
    Used to delete a registry in the Database using a registry id
    
    :param: id    NSNumber with id of the registry to be deleted
    
    :returns: nil
    */
    static func deleteRegistryByName(registryID:NSNumber)
    {
        // create operation
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            // find registry
            var registry:Registry? = RegistryDAO.findFirstById(registryID)
            if (registry != nil)
            {
                // delete registry
                RegistryDAO.delete(registry!)
            }
        })
        
        // execute operation
        SharedServices.OperationQueue.addOperation(deleteOperation)
    }
    
    /**
    Used to get all registries from database, ordered by Date Added
    
    :param: nil
    
    :returns: array of Registry
    */
    static func getRegistryListOrderedByDateAdded() -> [Registry] {
        return RegistryDAO.getRegistriesListOrderedByDateAdded()
    }
    
    /**
    Used to get all registries from database, ordered by Date Chosen (on calendar)
    
    :param: nil
    
    :returns: array of Registry
    */
    static func getRegistryListOrderedByDateChosen() -> [Registry] {
        return RegistryDAO.getRegistriesListOrderedByDateChosen()
    }
    
    /**
    Used to get a registry from the database using a registry name
    
    :param: registryID        NSNumber with id of a registry
    
    :returns: first registry found
    */
    static func getRegistryByID(registryID:NSNumber) -> Registry {
        var registry:Registry? = RegistryDAO.findFirstById(registryID)
        if (registry == nil)
        {
            println("No registry found with id \"\(registry)\"")
        }
        return registry!
    }
}
