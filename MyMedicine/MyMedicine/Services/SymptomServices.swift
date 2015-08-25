//
//  SymptomServices.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import CoreData

class SymptomServices {
    // MARK: Symptom Operations
    /**
    Used to add a symptom to database
    
    :param: name            String with name of symptom
    :param: description     String with description of symptom
    
    :returns: nil
    */
    static func createSymptom(name:String, description:String)
    {
        var symptom : Symptom = Symptom()
        symptom.name = name
        symptom.descriptionTxt = description
        
        // insert it
        SymptomDAO.insert(symptom)
    }
    
    /**
    Used to add a specialist to a symptom
    
    :param: symptom         Symptom that a specialist treats
    :param: specialist      Specialist that treats the symptom
    
    :returns: nil
    */
    static func addSymptom(symptom:Symptom, specialist:Specialist)
    {
        symptom.addSpecialistObject(specialist)
    }
    
    /**
    Used to delete a symptom in the Database using a symptom name
    
    :param: name    name of the symptom to be deleted
    
    :returns: nil
    */
    static func deleteSymptomByName(name:String)
    {
        // create operation
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            // find company
            var symptom:Symptom? = SymptomDAO.findFirstByName(name)
            if (symptom != nil)
            {
                // delete company
                SymptomDAO.delete(symptom!)
            }
        })
        
        // execute operation
        SharedServices.OperationQueue.addOperation(deleteOperation)
    }
    
    /**
    Used to get all symptoms from database
    
    :param: nil
    
    :returns: array of Symptom
    */
    static func getSymptomList() -> [Symptom] {
        return SymptomDAO.getSymptomsList()
    }
    
    /**
    Used to get a symptom from the database using a symptom name
    
    :param: name        String with name of symptom
    
    :returns: first symptom found
    */
    static func getSymptomByName(name:String) -> Symptom {
        var symptom:Symptom? = SymptomDAO.findFirstByName(name)
        if (symptom == nil)
        {
            println("No symptom found with name \"\(name)\"")
        }
        return symptom!
    }
}

