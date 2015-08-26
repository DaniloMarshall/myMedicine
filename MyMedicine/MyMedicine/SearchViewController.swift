//
//  SearchViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SharedServices.CheckSavedData()
        
        var symptomsList = SharedServices.RetrieveSavedSymptoms()
        
        for symptom in symptomsList {
            println(symptom.name)
        }
        
        var medicinesList = SharedServices.RetrieveSavedMedicines()
        for medicine in medicinesList {
            println(medicine.name)
        }
        
        var specialistsList = SharedServices.RetrieveSavedSpecialists()
        for specialist in specialistsList {
            if specialist.symptoms.count > 0 {
                let numSymptoms = specialist.symptoms.count
                var i = 0
                
                var symptomList = ""
                
                for symptom in specialist.symptoms {
                    symptomList += (symptom as! Symptom).name
                    
                    if i+1 < numSymptoms {
                        symptomList += ","
                    }
                    
                    i++
                }
                println("Specialist \(specialist.name): \(symptomList)")
            } else {
                println("Specialist \(specialist.name)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
