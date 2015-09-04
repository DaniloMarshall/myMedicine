//
//  TabViewController.swift
//  MyMedicine
//
//  Created by Fernando H M Bastos on 8/28/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.navigationController!.navigationBar.tintColor = UIColor(red: 0.16, green: 0.68, blue: 0.62, alpha: 1.0)
        self.tabBar.tintColor = UIColor(red: 0.16, green: 0.68, blue: 0.62, alpha: 1.0)


        

        // Do any additional setup after loading the view.
    }
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
    
        
        
        if(tabBarController.selectedViewController is SearchViewController){
        
            
            let vc = tabBarController.selectedViewController as! SearchViewController
        
            vc.controller.dismissViewControllerAnimated(true,
                completion: nil)
        }
        
        return true
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
