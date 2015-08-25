//
//  SharedServices.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/25/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation

class SharedServices {
    // Queue used for all DB operations
    static let OperationQueue : NSOperationQueue = NSOperationQueue()
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: Data persistency operations
    /**
    Used to check if there is any saved data in DB, if there isn't will call function to create default data
    
    :param: nil
    
    :returns: nil
    */
    static func CheckSavedData() {
        if var hasDefaultData = defaults.stringForKey("hasDefaultData") as String!
        {
            // Case where data was already saved at least once
            defaults.setObject("true", forKey: "hasDefaultData") // just making sure variable has correct data
        }
        else {
            // Case where data was never set
            CreateFakeData()
            defaults.setObject("true", forKey: "hasDefaultData")
        }
    }
    
    /**
    Used to create fake data in the DB
    
    :param: nil
    
    :returns: nil
    */
    static func CreateFakeData() {
        
        
    }
    
    // MARK: Data manipulation operations
    /*
    static func RetrieveSavedDestinations() -> [Destination] {
        return DestinationDAO.getDestinationsList()
    }
    */
    
}
