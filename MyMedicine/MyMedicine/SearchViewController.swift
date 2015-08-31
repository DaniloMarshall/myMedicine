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
    
    
    
    var symptomsList : [Symptom]! = nil
    var filteredSymptomsList = [Symptom]()
    
    var medicineList : [Medicine]! = nil
    var filteredMedicineList = [Medicine]()
    
//    var resultSearchController = UISearchController()
    
    
    

    let controller = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        print("didLoad Search")
        
        SharedServices.CheckSavedData()
        
        symptomsList = SharedServices.RetrieveSavedSymptoms()
        medicineList = SharedServices.RetrieveSavedMedicines()
        
        for medicine in medicineList {
            
            println(medicine.name)
            
            
        }
        
        super.viewDidLoad()
        
        searchType.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
        
        
        searchTypeText.hidden = false
        
        
        
        
        
        
        self.controller.searchResultsUpdater = self
        self.controller.dimsBackgroundDuringPresentation = false
        self.controller.searchBar.sizeToFit()
        self.controller.hidesNavigationBarDuringPresentation = false
        self.controller.delegate = self
        self.controller.searchBar.delegate = self
        self.definesPresentationContext = true
        
        searchTypeText.text = "Faça sua pesquisa por Sintomas"
        searchTypeText.sizeToFit()
        
        
        self.resultsTable.tableHeaderView = self.controller.searchBar

        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        // Do any additional setup after loading the view.
        SharedServices.CheckSavedData()
        
        resultsTable.hidden = false
        self.resultsTable.reloadData()
        resultsTable.tableFooterView = UIView()
        
    }
    
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        
        if(searchType.selectedSegmentIndex == 0)
        {
            searchTypeText.text = "Faça sua pesquisa por Sintomas"
            searchTypeText.sizeToFit()
;
        }
        else if(searchType.selectedSegmentIndex == 1)
        {
            searchTypeText.text = "Faça sua pesquisa por Medicamentos"
            searchTypeText.sizeToFit()
;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
       
        
        super.viewWillDisappear(animated)
        
        
        
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchTypeText.hidden = true
        controller.searchBar.showsCancelButton = true
        controller.searchBar.hidden = false
        resultsTable.reloadData()
    }
    
    
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        controller.searchBar.showsCancelButton = false
        controller.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        controller.searchBar.showsCancelButton = false
        controller.searchBar.text = ""
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
    }
    
    // Cancel buttom behaviour
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        resultsTable.reloadData()
        searchTypeText.hidden = false

        // Clear any search criteria
        controller.searchBar.text = ""
        
        // Dismiss the keyboard
        controller.searchBar.resignFirstResponder()
        
        
        controller.searchBar.showsCancelButton = false
    }
    
    
    
    //retornos para a tableview da busca
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
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
    
    //cria as células-resultado na tabela de busca
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  resultsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ResultsTableViewCell
        
        switch searchOption.selectedSegmentIndex{

            case 0:
            
                if (self.controller.active){
                    cell.textLabel?.text = filteredSymptomsList[indexPath.row].name
                    return cell
                }
                
                else {
                    //cell.textLabel?.text = ""
                    //tableView.allowsSelection = false
                    cell.hidden = true
//                    searchTypeText.text = "Faça sua pesquisa por sintomas"
//                    searchTypeText.sizeToFit()
                    
                    return cell
                }

        
            case 1:
        
                if (self.controller.active){
                    cell.textLabel?.text = filteredMedicineList[indexPath.row].name
                    return cell
                }
                
                else {
                    //cell.textLabel?.text = ""
                    //tableView.allowsSelection = false
                    cell.hidden = true
                    searchTypeText.text = "Faça sua pesquisa por medicamentos"
                    searchTypeText.sizeToFit()

                    return cell
                }
            default:
                return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        
        
        switch searchOption.selectedSegmentIndex{

        case 0:
            filteredSymptomsList.removeAll(keepCapacity: false)
            
            let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text)
            let array = (symptomsList as NSArray).filteredArrayUsingPredicate(searchPredicate)
            self.filteredSymptomsList = array as! [Symptom]
            
            self.resultsTable.reloadData()
        
        
        case 1:
            
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
        
        let cell = self.resultsTable.cellForRowAtIndexPath(indexPath)
        
        
            performSegueWithIdentifier("segueSearch", sender: indexPath)
        
    }
    
    //segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueSearch"{
            
            
            if let destination = segue.destinationViewController  as? DetailsViewController{
                if let indexPath = resultsTable.indexPathForSelectedRow()?.row{
                    

                    
                    switch searchOption.selectedSegmentIndex{

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
