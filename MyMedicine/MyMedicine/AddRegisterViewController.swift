//
//  AddRegisterViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/28/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class AddRegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addBtn: UIButton!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    //@IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var datePickerAction: AnyObject!
    
    
    @IBOutlet weak var dailySwitch: UISwitch!
    @IBOutlet weak var fixedPeriodSwitch: UISwitch!
    @IBOutlet weak var daysOffSwitch: UISwitch!
    
    
    @IBOutlet weak var fixedPeriodView: UIView!
    @IBOutlet weak var daysOffView: UIView!
    
    
    @IBOutlet weak var fixedPeriodTxtField: UITextField!
    @IBOutlet weak var daysOnTxtField: UITextField!
    @IBOutlet weak var daysOffTxtField: UITextField!
    
    @IBOutlet weak var noteTxtView: UITextView!
    
    // MARK: Variables
    var addRegistryDate : NSDate = NSDate()
    
    
    var elementList : [TableElement]! = nil
    var filteredElementList : [TableElement]! = nil
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets current date to selectedLabel
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let currentDate = addRegistryDate
        var strDate = dateFormatter.stringFromDate(currentDate)
        //self.selectedDate.text = strDate
        
        elementList = SharedServices.getAllElementsList()

        
        //setup of resultSearchController
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.backgroundImage = UIImage.new()
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        // sets the selected date to selectedLabel
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        //self.selectedDate.text = strDate
        
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    @IBAction func addRegistry(sender: UIButton) {
        /*
            Jhen, adiciona registro nessa parte
            dateChosen é a data do pickerview, a data que vai ter o registro
            type é do tipo TypeRegistry (medicamento, especialista ou sintoma)
            isDaily se é um registro que vai repetir várias vezes (ainda não vi como apresentar se for assim)
            isFixedPeriod se é por um tempo determinado, por exemplo medicamentos antibioticos por 10 dias;
                            Se for tipo anti-concepcional que é por tempo indeterminado, coloca true aqui tb
            hasDaysOff se tem dias sem tomar (true/false)
            amountDaysOff   número de dias sem tomar (se for true antes)
            amountDaysOn    número de dias tomando (se for true antes)
            amountDaysPeriod   se for true na parte de periodo, esse valor vai ser verificado. No caso de anti-concepcional que não sabe o número de dias que vai tomar (pode ser para sempre), coloque 0
            note   alguma observação que o usuário tenha colocado
        */
        //RegistryServices.createRegistry(<#dateChosen: NSDate#>, type: <#TypeRegistry#>, isDaily: <#Bool#>, isFixedPeriod: <#Bool#>, hasDaysOff: <#Bool#>, amountDaysOff: <#Int32#>, amountDaysOn: <#Int32#>, amountDaysPeriod: <#Int32#>, note: <#String#>)
        navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func switchAction(sender: UISwitch) {
        
    }
    
    
    
    // MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.resultSearchController.active {
            
            return self.filteredElementList.count
            
        } else {
            
            return self.elementList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("addRegistryCell", forIndexPath: indexPath) as! AddRegisterTableViewCell
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        
        if self.resultSearchController.active {
            
            cell.nameLabel.text = self.filteredElementList[indexPath.row].name
            cell.typeLabel.text = self.filteredElementList[indexPath.row].type
            
        } else {
            
            cell.nameLabel.text = self.elementList[indexPath.row].name
            cell.typeLabel.text = self.elementList[indexPath.row].type
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.resultSearchController.active && self.resultSearchController.searchBar.text.isEmpty {
            
            //When filtering results && no text, animate from right to left.
            let initialCenterPosition = cell.center
            
            let offSetX = CGFloat(800 + (indexPath.row * 200))
            
            cell.center = CGPointMake(offSetX, initialCenterPosition.y)
            
            UIView.animateWithDuration(0.7, animations: {
                
                cell.center = CGPointMake(0, initialCenterPosition.y)
            })
        } else {
            
            cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
            
            UIView.animateWithDuration(0.25, animations: {
                
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //When the user selects the destination...
        if self.resultSearchController.active {
            self.resultSearchController.active = false
            
            var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            
            var searchedPlace:UILabel = cell.viewWithTag(10) as! UILabel
            
            //onSearch(searchedPlace.text!)
            
        }
    }
    
    // MARK: - Search Results Updating Delegate
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        
        //remove all results from the filtered list
        self.filteredElementList.removeAll(keepCapacity: false)
        
        //performs the search
        let array = self.searchForString(searchController.searchBar.text!)
        
        //if searchBar text field is empty, show all destinations, otherwise show filtered data
        if searchController.searchBar.text.isEmpty {
            self.filteredElementList = self.elementList
        } else {
            self.filteredElementList = array
        }
        
        //reload table view's data
        self.tableView.reloadData()
    }
    
    func searchForString(searchString:String) -> [TableElement] {
        //create a NSPredicate to use on the search
        let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchString)
        
        //create an array and populate it with the search result
        /*let array : [TableElement] = self.elementList.filter({m in
            m.name.lowercaseString.rangeOfString(searchString)})
        */
        
        //let array : [TableElement] = self.elementList.filter() {$0.name.lowercaseString.rangeOfString(searchString)}
        /*
        let array : [TableElement] = self.elementList.filter( { (m: TableElement) -> Bool in
            return m.name.lowercaseString.rangeOfString(searchString)
        })
        
        let array2 = self.elementList.filter( { (m: TableElement) -> Bool in
            return m.name.lowercaseString.rangeOfString(searchString)
        })
        */

        
        //let array = self.elementList.filter() { $0.name.lowercaseString.rangeOfString(searchString) }
        /*
        let array = (self.elementList.filter({ m in
            m.name.lowercaseString.rangeOfString(searchString)
        }) != nil)
        */
        //let array = (self.elementList as NSArray).filteredArrayUsingPredicate(searchPredicate)
        /*
        let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchString) //looking for the right name
        let array = (elementList as! NSArray).filteredArrayUsingPredicate(searchPredicate) //initializes an array for the colsest results
        */
        //self.filteredSymptomsList = array as! [Symptom] // save them
        
        return (array as [TableElement])
    }
}
