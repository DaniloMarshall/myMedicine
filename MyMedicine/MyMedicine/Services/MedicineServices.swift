//
//  MedicineServices.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import UIKit


class MedicineServices {
    // MARK: Medicine Operations
    /**
    Used to add a medicine to database
    
    :param: name                    String with name of medicine
    :param: typeMedicine            TypeMedicine with type of medicine that is being stored
    :param: infoLeaflet             NSData with information leaflet of the medicine
    :param: descriptionSummary      String with summary of the description of the medicine
    :param: posology                String with posology of the medicine
    :param: adverseEffects          String with adverse effects of the medicine
    :param: contraindication        String with contraindication of the medicine
    :param: photo                   UImage with photo of medicine. Use SharedServices.MedicineDefaultImage if not set.
    
    :returns: nil
    */
    static func createMedicine(name:String, typeMedicine:TypeMedicine, infoLeaflet:NSData, descriptionSummary:String, posology:String, adverseEffects:String, contraindication:String, photo:UIImage)
    {
        var medicine : Medicine = Medicine()
        medicine.name = name
        medicine.typeEnum = typeMedicine
        medicine.informationLeaflet = infoLeaflet
        medicine.descriptionSummary = descriptionSummary
        medicine.posology = posology
        medicine.adverseEffects = adverseEffects
        medicine.contraindication = contraindication
        
        let imageData : NSData = UIImagePNGRepresentation(photo)
        medicine.photo = imageData
        
        
        // insert it
        MedicineDAO.insert(medicine)
    }
    
    /**
    Used to delete a medicine in the Database using a medicine name
    
    :param: name    name of the medicine to be deleted
    
    :returns: nil
    */
    static func deleteMedicineByName(name:String)
    {
        // create operation
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            // find medicine
            var medicine:Medicine? = MedicineDAO.findFirstByName(name)
            if (medicine != nil)
            {
                // delete medicine
                MedicineDAO.delete(medicine!)
            }
        })
        
        // execute operation
        SharedServices.OperationQueue.addOperation(deleteOperation)
    }
    
    /**
    Used to get all medicine from database
    
    :param: nil
    
    :returns: array of Medicine
    */
    static func getMedicineList() -> [Medicine] {
        return MedicineDAO.getMedicinesList()
    }
    
    
    /**
    Used to get a medicine from the database using a medicine name
    
    :param: name        String with name of medicine
    
    :returns: first medicine found
    */
    static func getMedicineByName(name:String) -> Medicine {
        var medicine:Medicine? = MedicineDAO.findFirstByName(name)
        if (medicine == nil)
        {
            println("No medicine found with name \"\(name)\"")
        }
        return medicine!
    }
}
