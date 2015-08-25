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
