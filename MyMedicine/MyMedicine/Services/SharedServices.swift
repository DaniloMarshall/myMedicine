//
//  SharedServices.swift
//  MyMedicine
//
//  Created by Danilo S Marshall on 8/25/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import Foundation
import UIKit

class SharedServices {
    // Queue used for all DB operations
    static let OperationQueue : NSOperationQueue = NSOperationQueue()
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    //Get the local docs directory and append your local filename.
    static let docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as? NSURL
    
    // Default images, that should be used whenever it's needed to create a new data and image is not yet set
    static let MedicineDefaultImage : UIImage = UIImage(named: "pharmacy_default")!
    
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
        /*
        // Creating Symptoms
        SymptomServices.createSymptom("Dor de cabeca", description: "Tipos de dor de cabeca...")
        
        // Creating Specialists
        SpecialistServices.createSpecialist("Clinico Geral", description: "Clínica médica, no Brasil também conhecida como Medicina Interna,\n" +
            "é a especialidade médica que trata de pacientes adultos, atuando,\n" +
            "principalmente em ambiente hospitalar. Inclui o estudo das doenças de,\n" +
            "adultos, não cirúrgicas, não obstétricas e não ginecológicas, sendo a,\n" +
            "especialidade médica a partir da qual se diferenciaram todas as outras áreas,\n" +
            "clínicas.,\n" +
            "No Brasil, o especialista em clínica médica deve cumprir, além do curso de,\n" +
            "Medicina, dois anos de Residência médica em Clínica Médica. O termo \"clínico,\n" +
            "geral\" é erroneamente e popularmente utilizado para designar o médico sem,\n" +
            "especialização. O termo mais correto para designar o médico sem,\n" +
            "especialização é \"generalista\".")
        
        let dorDeCabeca : Symptom = SymptomServices.getSymptomByName("Dor de cabeca")
        let clinicoGeral : Specialist = SpecialistServices.getSpecialistByName("Clinico Geral")
        
        SpecialistServices.addSymptom(clinicoGeral, symptom: dorDeCabeca)
        
        
        // Creating Medicines
        let salompasDescription : String = "Este medicamento é indicado para alívio de dores e inflamações nas\n" +
            "seguintes condições: fadiga muscular, dores musculares e lombares, rigidez nos\n" +
            "ombros, contusões, pancadas, torções, entorses,torcicolo, dores nas costas,\n" +
            "nevralgia e dores articulares."
        let salompasPosology : String = "Usar sobre a área afetada"
        let salompasAdverseEffects : String = "Irritação na pele por uso prolongado"
        let salompasContraindication : String = "Sem contra-indicações"
        
        var pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("airSalompas", ofType:"pdf")!)
        let salompasData = NSData(contentsOfURL: pdfLoc!)

        MedicineServices.createMedicine("Salonpas", typeMedicine: TypeMedicine.registered, infoLeaflet: salompasData!, descriptionSummary: salompasDescription, posology: salompasPosology, adverseEffects: salompasAdverseEffects, contraindication: salompasContraindication, photo: MedicineDefaultImage)
        */
        
        // Create a default leaflet with 'Air Salompas' information leaflet
        var pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("airSalompas", ofType:"pdf")!)
        let salompasData = NSData(contentsOfURL: pdfLoc!)
        
        let filePath = NSBundle.mainBundle().pathForResource("medbase",ofType:"json")
        var readError:NSError?
        if let data = NSData(contentsOfFile:filePath!, options:NSDataReadingOptions.DataReadingUncached, error:&readError) {
            let stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("data read: \(stringData)")
            
            let jsonData = JSON(data: data, options: nil, error: &readError)
            
            // Adding Symptons
            let numSymptoms = jsonData["symptoms"].count
            for var i = 0; i < numSymptoms; i++ {
                SymptomServices.createSymptom(jsonData["symptoms"][i]["name"].string!, description: jsonData["symptoms"][i]["description"].string!)
            }
            
            // Adding Specialists
            let numSpecialists = jsonData["specialists"].count
            for var i = 0; i < numSpecialists; i++ {
                SpecialistServices.createSpecialist(jsonData["specialists"][i]["name"].string!, description: jsonData["specialists"][i]["description"].string!)
            }
            
            // Adding Medicines
            let numMedicines = jsonData["medicines"].count
            
            for var i = 0; i < numMedicines; i++ {
                let typeData = jsonData["medicines"][i]["type"].string
                var typeMedicine : TypeMedicine = .generic
                
                switch typeData! {
                case "registered":
                    typeMedicine = .registered
                case "generic":
                    typeMedicine = .generic
                case "homeopathic":
                    typeMedicine = .homeopathic
                case "phytotherapic":
                    typeMedicine = .phytotherapic
                default:
                    typeMedicine = .generic
                }
                
                var specificLeaflet = salompasData
                
                if jsonData["medicines"][i]["leaflet"] != "" {
                    // get specific information leaflet
                }
                
                MedicineServices.createMedicine(jsonData["medicines"][i]["name"].string!, typeMedicine: typeMedicine, infoLeaflet: salompasData!, descriptionSummary: jsonData["medicines"][i]["description"].string!, posology: jsonData["medicines"][i]["posology"].string!, adverseEffects: jsonData["medicines"][i]["adverseEffects"].string!, contraindication: jsonData["medicines"][i]["contraindication"].string!, photo: MedicineDefaultImage)
                
            }
            
            // Adding Symptom-Specialist connections
            let numSymptomsConnected = jsonData["symptoms_specialists"].count
            for var i = 0; i < numSymptomsConnected; i++ {
                let symptom : Symptom = SymptomServices.getSymptomByName(jsonData["symptoms_specialists"][i]["symptom_name"].string!)
                
                let numSpecialistsForSymptom = jsonData["symptoms_specialists"][i]["specialists_name_list"].count
                for var j = 0; j < numSpecialistsForSymptom; j++ {
                    let specialist : Specialist = SpecialistServices.getSpecialistByName(jsonData["symptoms_specialists"][i]["specialists_name_list"][j].string!)
                    
                    SpecialistServices.addSymptom(specialist, symptom: symptom)
                }
            }
            
            //println("json data: \(jsonMedicines)")
        }
        
    }
    
    // MARK: Data manipulation operations
    
    static func RetrieveSavedSymptoms() -> [Symptom] {
        return SymptomDAO.getSymptomsList()
    }
    
    static func RetrieveSavedSpecialists() -> [Specialist] {
        return SpecialistDAO.getSpecialistsList()
    }
    
    static func RetrieveSavedMedicines() -> [Medicine] {
        return MedicineDAO.getMedicinesList()
    }

}
