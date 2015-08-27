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
            Description.text = object.description as String
            
            
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


