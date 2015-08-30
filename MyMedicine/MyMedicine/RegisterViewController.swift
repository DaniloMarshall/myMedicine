//
//  RegisterViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var isFromSpecificDay : Bool = false
    var recordsList : [Registry]! = nil
    
    var filteredList : [Registry]! = nil
    
    var pickerViewData = ["Todos","Medicamentos","Sintomas","Especialistas"]
    var currentlySelectedPickerData = 0
    
    @IBOutlet weak var registryTypePickerView: UIPickerView!
    @IBOutlet weak var registryTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filteredList = recordsList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Picker View
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerViewData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerViewData[row] == "Todos" { // All
            currentlySelectedPickerData = 0
            filteredList = recordsList
        } else if pickerViewData[row] == "Medicamentos" { // Medicines
            currentlySelectedPickerData = 1
            filteredList = SharedServices.filterRegistries(recordsList, filter: .medicine)
        } else if pickerViewData[row] == "Sintomas" { // Symptoms
            currentlySelectedPickerData = 2
            filteredList = SharedServices.filterRegistries(recordsList, filter: .symptom)
        } else { // Specialists
            currentlySelectedPickerData = 3
            filteredList = SharedServices.filterRegistries(recordsList, filter: .specialist)
        }
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

extension RegisterViewController : UITableViewDataSource, UITableViewDelegate {
    // MARK:  UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredList == nil {
            return Int(0)
        }
        else {
            return filteredList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = registryTable.dequeueReusableCellWithIdentifier("registryCell", forIndexPath: indexPath) as! UITableViewCell
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.TouchedIndex = indexPath.row;
        
        if(tableView == GenericTableView) {
            self.TouchedTable = "Generic"
            
        }
        else if(tableView == HomeopathicTableView) {
            self.TouchedTable = "Homeopathic"
        }
        
        [self .performSegueWithIdentifier("GoToDescription", sender: self)]
        */
    }
}
