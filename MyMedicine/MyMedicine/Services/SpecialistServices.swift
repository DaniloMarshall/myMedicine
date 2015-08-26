//
//  File.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class SpecialistServices {
    // MARK: Specialist Operations
    /**
    Used to add a specialist to database
    
    :param: name            String with name of specialist
    :param: description     String with description of specialist
    
    :returns: nil
    */
    static func createSpecialist(name:String, description:String)
    {
        var specialist : Specialist = Specialist()
        specialist.name = name
        specialist.descriptionTxt = description
        
        // insert it
        SpecialistDAO.insert(specialist)
    }
    
    /**
    Used to add a symptom to a specialist
    
    :param: specialist      Specialist that treats a specific symptom
    :param: symptom         Symptom that the specialist treats
    
    :returns: nil
    */
    static func addSymptom(specialist:Specialist, symptom:Symptom)
    {
        specialist.addSymptomObject(symptom)
    }
    
    /**
    Used to delete a specialist in the Database using a specialist name
    
    :param: name    name of the specialist to be deleted
    
    :returns: nil
    */
    static func deleteSpecialistByName(name:String)
    {
        // create operation
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            // find company
            var specialist:Specialist? = SpecialistDAO.findFirstByName(name)
            if (specialist != nil)
            {
                // delete company
                SpecialistDAO.delete(specialist!)
            }
        })
        
        // execute operation
        SharedServices.OperationQueue.addOperation(deleteOperation)
    }
    
    /**
    Used to get all specialists from database
    
    :param: nil
    
    :returns: array of Specialist
    */
    static func getSpecialistList() -> [Specialist] {
        return SpecialistDAO.getSpecialistsList()
    }
    
    /**
    Used to get a specialist from the database using a specialist name
    
    :param: name        String with name of specialist
    
    :returns: first specialist found
    */
    static func getSpecialistByName(name:String) -> Specialist {
        var specialist:Specialist? = SpecialistDAO.findFirstByName(name)
        if (specialist == nil)
        {
            println("No specialist found with name \"\(name)\"")
        }
        return specialist!
    }
}
