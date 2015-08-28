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
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var typeMed: UILabel!
    @IBOutlet weak var posology: UILabel!
    @IBOutlet weak var adverseEffects: UILabel!
    @IBOutlet weak var contraIndication: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    func adjustContentSize() {
        var contentRect = CGRectZero
        for view in self.scroll.subviews {
            contentRect = CGRectUnion(contentRect, view.frame)
        }
        
        self.scroll.contentSize = contentRect.size
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            
            
        if let object = currentObject as? Symptom{
            
            name.text = object.name as String
            Description.text = object.descriptionTxt as String
            posology.hidden = true
            adverseEffects.hidden = true
            contraIndication.hidden = true
            typeMed.hidden = true
            
            Description.numberOfLines = 0
            Description.sizeToFit()
            adjustContentSize()

            
            }
        
        else if let object = currentObject as? Medicine{
            
            name.text = object.name as String
            Description.text = object.descriptionSummary as String
            posology.text = object.posology as String
            adverseEffects.text = object.adverseEffects as String
            contraIndication.text = object.contraindication as String
            



            Description.numberOfLines = 0
            Description.sizeToFit()
            adjustContentSize()
            
            
        }
            
            
            
        
        
        adjustContentSize()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


