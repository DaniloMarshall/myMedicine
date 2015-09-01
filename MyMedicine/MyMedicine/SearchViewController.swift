//
//  SearchViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
    
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchType: UISegmentedControl!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchOption: UISegmentedControl!
    @IBOutlet weak var searchTypeText: UILabel!
    
    
    // testing search function
    //let test = ["one", "alone", "two", "car"]
    //var filteredTest = [String]()
    
    
    //initialize symptoms and medicine lists and filtered lists variables
    
    var symptomsList : [Symptom]! = nil
    var filteredSymptomsList = [Symptom]()
    
    var medicineList : [Medicine]! = nil
    var filteredMedicineList = [Medicine]()
    
    
    //controller initializer
    let controller = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        
        //calls DB
        SharedServices.CheckSavedData()
        
        //Save data in variables
        symptomsList = SharedServices.RetrieveSavedSymptoms()
        medicineList = SharedServices.RetrieveSavedMedicines()
        
//        //test if list has the right values
//        for medicine in medicineList {
//            println(medicine.name)
//        }
        
        super.viewDidLoad()
        
        //adding target to seg control change
        searchType.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
        
        //shows initial message
        searchTypeText.hidden = false
        
        //search bar appearance
        self.controller.searchBar.barTintColor = UIColor(red: 0.16, green: 0.68, blue: 0.62, alpha: 1.0)
        self.controller.searchBar.tintColor = UIColor(white: 1, alpha: 1)
        
        let view: UIView = self.controller.searchBar.subviews[0] as! UIView
        let subViewsArray = view.subviews
        
        for (subView: UIView) in subViewsArray as! [UIView] {
            println(subView)
            if subView.isKindOfClass(UITextField){
                subView.tintColor = UIColor(red: 0.16, green: 0.68, blue: 0.62, alpha: 1.0)
            }
        }
        
        
        //setting delegates
        self.controller.searchResultsUpdater = self
        self.controller.dimsBackgroundDuringPresentation = false
        self.controller.searchBar.sizeToFit()
        self.controller.hidesNavigationBarDuringPresentation = false
        self.controller.delegate = self
        self.controller.searchBar.delegate = self
        self.definesPresentationContext = true
        
        //default text for search tab
        searchTypeText.text = "Faça sua pesquisa por Sintomas"
        searchTypeText.sizeToFit()
        
        //creates a search bar as header for the table view
        self.resultsTable.tableHeaderView = self.controller.searchBar

        //yay, more delegates...
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        // Do any additional setup after loading the view.
        SharedServices.CheckSavedData()
        
        //load results table
        resultsTable.hidden = false
        self.resultsTable.reloadData()
        resultsTable.tableFooterView = UIView()
        
    }
    
    
    //segmented control behaviour
    @IBAction func segmentedControlAction(sender: AnyObject) {
        
        //each option has a deafault message
        
        if(searchType.selectedSegmentIndex == 0){
            
            searchTypeText.text = "Faça sua pesquisa por Sintomas"
            searchTypeText.sizeToFit()
            controller.searchBar.text = ""
            
        }
        
        else if(searchType.selectedSegmentIndex == 1){
            
            searchTypeText.text = "Faça sua pesquisa por Medicamentos"
            searchTypeText.sizeToFit()
            controller.searchBar.text = ""

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //search bar text begins editing
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchTypeText.hidden = true //hides default message
        controller.searchBar.showsCancelButton = true //enable cancel button
        controller.searchBar.hidden = false //keep search up
        resultsTable.reloadData() //reload data
    }
    
    
    //search bar end editing
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        controller.searchBar.showsCancelButton = false //dismiss cancel button
        controller.searchBar.resignFirstResponder() //dismiss keyboard
    }
    
    //search clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false //dismiss cancel button
        //controller.searchBar.text = ""  //clears text field
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
    }
    
    // Cancel buttom behaviour
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        
        resultsTable.reloadData()
        searchTypeText.hidden = false //shows default text

        // Clear any search criteria
        controller.searchBar.text = ""
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        //dismiss cancel button
        controller.searchBar.showsCancelButton = false
    }
    
    
    
    //returns number of rows for search table
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //search for each option - symptom or medicine
        switch searchOption.selectedSegmentIndex{
        
            case 0:
                if (self.controller.active){
                    return self.filteredSymptomsList.count
                }
                else{
                    return self.symptomsList.count
                }
        
            case 1:
        
                if (self.controller.active){
                    return self.filteredMedicineList.count
                }
                else{
                    return self.medicineList.count
                }
            default:
                return 0
        }
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    // creates the results' cells
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //init cell
        let cell =  resultsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultsTableViewCell
        
        //cases for type of search
        switch searchOption.selectedSegmentIndex{

            case 0:
            
                if (self.controller.active){
                    
                    cell.textLabel?.text = filteredSymptomsList[indexPath.row].name
                    return cell
                }
                
                else {
                    
                    cell.hidden = true
                    return cell
                }

        
            case 1:
        
                if (self.controller.active){
                    cell.textLabel?.text = filteredMedicineList[indexPath.row].name
                    return cell
                }
                
                else {
                    cell.hidden = true
                    return cell
                }
            default:
                return cell
        }
    }
    
    //keep updating the results for search
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        
        
        switch searchOption.selectedSegmentIndex{

        case 0:
           
            filteredSymptomsList.removeAll(keepCapacity: false)
            
            let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text) //looking for the right name
            let array = (symptomsList as NSArray).filteredArrayUsingPredicate(searchPredicate) //initializes an array for the colsest results
            self.filteredSymptomsList = array as! [Symptom] // save them
            
            self.resultsTable.reloadData()
        
        
        case 1: //same as 0, for medicine
            
            filteredMedicineList.removeAll(keepCapacity: false)
            
            let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text)
            let array = (medicineList as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.filteredMedicineList = array as! [Medicine]
            
            self.resultsTable.reloadData()
        
        default:
            
            self.resultsTable.reloadData()
        }
        
    }


    //prepare for segue
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let cell = self.resultsTable.cellForRowAtIndexPath(indexPath)
        
        
            performSegueWithIdentifier("segueSearch", sender: indexPath)
        
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueSearch"{
            
            
            if let destination = segue.destinationViewController  as? DetailsViewController{
                if let indexPath = resultsTable.indexPathForSelectedRow()?.row{
                    

                    
                    switch searchOption.selectedSegmentIndex{ // creates the right object for destination

                    case 0:
                        let row = Int(indexPath)
                        destination.currentObject = (filteredSymptomsList[row]) as Symptom
                        
                    case 1:
                        let row = Int(indexPath)
                        destination.currentObject = (filteredMedicineList[row]) as Medicine
                    
                    default:
                        break
                    }
                }
            }
        }
    }

    
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
