//
//  DetailsViewController.swift
//  MyMedicine
//
//  Created by Fernando H M Bastos on 8/27/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var currentObject: AnyObject!
    
    //scroll init
    @IBOutlet weak var scroll: UIScrollView!
    
    //labels block init
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var typeMed: UILabel!
    @IBOutlet weak var posology: UILabel!
    @IBOutlet weak var posologyTitle: UILabel!
    @IBOutlet weak var adverseEffects: UILabel!
    @IBOutlet weak var adverseEffectsTitle: UILabel!
    @IBOutlet weak var contraIndication: UILabel!
    @IBOutlet weak var contraIndicationTitle: UILabel!
    @IBOutlet weak var typeTitle: UILabel!
    
    //button init
    @IBOutlet weak var leafletButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //the details page will load different info in accordance with the respective medicine
        
        if let object = currentObject as? Symptom{ //symptom case
            
            //load the info
            name.text = object.name as String
            Description.text = object.descriptionTxt as String
            
            //keeps unused info hidden
            posology.hidden = true
            posologyTitle.hidden = true
            adverseEffects.hidden = true
            adverseEffectsTitle.hidden = true
            contraIndication.hidden = true
            contraIndicationTitle.hidden = true
            typeMed.hidden = true
            typeTitle.hidden = true
            leafletButton.hidden = true
            
            Description.numberOfLines = 0
            Description.sizeToFit()
            
            
        }
            
        else if let object = currentObject as? Medicine{ //medicine case
            
            //load info
            name.text = object.name as String
            Description.text = object.descriptionSummary as String
            posology.text = object.posology as String
            adverseEffects.text = object.adverseEffects as String
            contraIndication.text = object.contraindication as String
            
            //for the type we have to discover the return for the enum - suggest to change the return type of typeEnum to the string for structural organization
            switch object.type{
                
            case 0:
                typeMed.text = "Registrado"
            case 1:
                typeMed.text = "Genérico"
            case 2:
                typeMed.text = "Homeopático"
            case 3:
                typeMed.text = "Fitoterápico"
            default:
                break
            }
            
            //layout for text
            name.numberOfLines = 0
            name.sizeToFit()
            Description.numberOfLines = 0
            Description.sizeToFit()
            posology.numberOfLines = 0
            posology.sizeToFit()
            adverseEffects.numberOfLines = 0
            adverseEffects.sizeToFit()
            adverseEffects.numberOfLines = 0
            adverseEffects.sizeToFit()
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //leaflet button behaviour: will perform segue to webview
    
    @IBAction func segue(sender: UIButton) {
        
        performSegueWithIdentifier("segueLeaflet", sender: leafletButton)
        
    }
    
    //prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueLeaflet"{
            if let destination = segue.destinationViewController  as? LeafletViewController{
                
                destination.currentLeaflet = self.currentObject
                
            }
            
            
        }
        
    }
    
    
}


