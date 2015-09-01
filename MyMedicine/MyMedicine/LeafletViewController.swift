//
//  LeafletViewController.swift
//  MyMedicine
//
//  Created by Fernando H M Bastos on 8/31/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class LeafletViewController: UIViewController {

    @IBOutlet weak var leafletView: UIWebView!
   
    var currentLeaflet: AnyObject!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //will load the medcine's leaflet - not implemented yet
        if let object: AnyObject = currentLeaflet{
        
        //load the leaflet pdf
        var pdfLoc = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("airSalompas", ofType:"pdf")!)
        var request = NSURLRequest(URL: pdfLoc!);
        self.leafletView?.loadRequest(request);
        
        }
        // Do any additional setup after loading the view.
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
