//
//  CalendarViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/24/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    static let daysArraySize = 31

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    
    @IBOutlet weak var monthLabel: UILabel!
 //   @IBOutlet weak var daysOutSwitch: UISwitch!
    
    var shouldShowDaysOut : Bool = true
    var animationFinished : Bool = true
    
    
    // Data Manipulation variables
    var hasRecordsForSelectedDate : Bool = false
    var fullRecordsList : [Registry]! = nil
    var dailyRecordsList : [Registry]! = nil
    
    var currentMonthRecordsList : [Registry]! = nil
    var currentMonthDaysList : [Int] = [Int](count: daysArraySize, repeatedValue: 0)
    
    
    var currentMonthDate : NSDate = NSDate()
    let currentCalendar = NSCalendar.currentCalendar()
    
    // Fixed color for each type of event
    // specialist: 45, 192, 188
    // medicine: 255, 233, 186
    // symptom: 255, 139, 30
    let medicineColor = UIColor(red: 1, green: 0.91372549, blue: 0.72941176, alpha: 1)
    let specialistColor = UIColor(red: 0.17647059, green: 0.75294118, blue: 0.7372549, alpha: 1)
    let symptomColor = UIColor(red: 1, green: 0.54509804, blue: 0.11764706, alpha: 1)
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.calendarView.commitCalendarViewUpdate()
        self.calendarMenuView.commitMenuViewUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel.text = CVDate(date: NSDate()).globalDescription

        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        
        // Menu delegate [Required]
        self.calendarMenuView.menuViewDelegate = self
        
        
        fullRecordsList = RegistryServices.getRegistryListOrderedByDateChosen()
        
        
        updateMonthList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addRegister" {
            let addRegisterVC : AddRegisterViewController = segue.destinationViewController as! AddRegisterViewController
        }
        else if segue.identifier == "showRecords" {
            let registerVC : RegisterViewController = segue.destinationViewController as! RegisterViewController
            if hasRecordsForSelectedDate {
                registerVC.isFromSpecificDay = true
                registerVC.recordsList = dailyRecordsList
                
            }
            else {
                registerVC.recordsList = fullRecordsList
                registerVC.isFromSpecificDay = false
            }
        }
    }
}

// MARK: Data Manipulation
enum TypeDots : Int16 {
    case medicine = 0
    case specialist = 1
    case symptom = 2
    case medicine_specialist = 3
    case medicine_symptom = 4
    case specialist_symptom = 5
    case medicine_specialist_symptom = 6
    case unknown = -1
}

extension CalendarViewController {
    func getDayOfRegistry(date : NSDate) -> Int {
        let currentDateComponents = self.currentCalendar.components(.CalendarUnitDay, fromDate: date)
        return currentDateComponents.day
    }
    
    func updateMonthList() {
        currentMonthRecordsList = RegistryServices.getRegistryListFromCurrentMonth(currentMonthDate)
        
        //currentMonthDaysList.removeAll(keepCapacity: false)
        clearDaysListArray()
        
        for var i = 0; i < currentMonthRecordsList.count; i++ {
            let record = currentMonthRecordsList[i]
            currentMonthDaysList[self.getDayOfRegistry(record.dateChosen)]++
        }
    }
    
    func clearDaysListArray() {
        for var i = 0; i < currentMonthDaysList.count; i++ {
            currentMonthDaysList[0] = 0
        }
    }
    
    func checkDayInList(dayToCheck: Int) -> Bool {
        if currentMonthDaysList.isEmpty {
            return false
        }
        else {
            if currentMonthDaysList[dayToCheck-1] > 0 {
                return true
            }
            else {
                return false
            }
        }
    }
    
    func getDottedRegistries(day: Int, amount: Int) -> [Registry] {
        var dottedList : [Registry]! = nil
        
        var numRegistriesFound = 0
        for var i = 0; i < currentMonthRecordsList.count && numRegistriesFound < amount; i++ {
            if(getDayOfRegistry(currentMonthRecordsList[i].dateChosen) == (day-1)) {
                numRegistriesFound++
                dottedList.append(currentMonthRecordsList[i])
            }
        }
        if numRegistriesFound != amount {
            println("Was expecting \(amount) registry(ies) and found \(numRegistriesFound)")
        }
        return dottedList
    }
    
    func checkTypeRegistries(list: [Registry]) -> (typeCount: Int, typeDots: TypeDots) {
        var hasSpecialist = false
        var hasMedicine = false
        var hasSymptom = false
        
        //var types : [TypeRegistry]! = nil
        
        for var i = 0; i < list.count; i++ {
            switch list[i].typeEnum {
            case .medicine:
                hasMedicine = true
                //types.append(TypeRegistry.medicine)
            case .specialist:
                hasSpecialist = true
                //types.append(TypeRegistry.specialist)
            case .symptom:
                hasSymptom = true
                //types.append(TypeRegistry.symptom)
            default:
                println("Unknown type of Registry: \(list[i].typeEnum)")
                //types.append(TypeRegistry.unknown)
            }
        }
        
        if hasSpecialist {
            if hasMedicine {
                if hasSymptom {
                    return (3,TypeDots.medicine_specialist_symptom)
                }
                else {
                    return (2,TypeDots.medicine_specialist)
                }
            }
            else if hasSymptom {
                return (2,TypeDots.specialist_symptom)
            }
            else {
                return (1,TypeDots.specialist)
            }
        }
        else if hasMedicine {
            if hasSymptom {
                return (2,TypeDots.medicine_symptom)
            }
            else {
                return (1,TypeDots.medicine)
            }
        }
        else if hasSymptom {
            return (1,TypeDots.symptom)
        }
        else {
            println("Found no known Registry!")
            return (0,TypeDots.unknown)
        }
    }
}


// MARK: - CVCalendarViewDelegate

extension CalendarViewController: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return self.shouldShowDaysOut
        //return true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date // return the day tapped
        println("\(calendarView.presentedDate.commonDescription) is selected!")
        
        // Check if there is any record on date selected
        let day = dayView.date.day
        
        // get registries for this day
        dailyRecordsList = getDottedRegistries(day, amount: currentMonthDaysList[day])
        
        // Perform segue
        performSegueWithIdentifier("showRecords", sender: nil)
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        
        return checkDayInList(day)
        
        /*
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
        return false
        */
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let day = dayView.date.day
        
        var numRegistries = currentMonthDaysList[day]
        
        // get registries for this day
        var listRegistries = getDottedRegistries(day, amount: numRegistries)
        
        
        
        // Check registry for each dotted day
        let dots = checkTypeRegistries(listRegistries)
        
        // Add up to 3 dots on a date, one for each type of registry
        switch(dots.typeCount) {
        case 2:
            switch dots.typeDots {
            case .medicine_specialist:
                return [medicineColor,specialistColor]
            case .medicine_symptom:
                return [medicineColor,symptomColor]
            default:
                return [specialistColor,symptomColor]
            }
        case 3:
            return [medicineColor, specialistColor, symptomColor]
        default:
            // return 1 dot
            switch dots.typeDots {
            case .medicine:
                return [medicineColor]
            case .specialist:
                return [specialistColor]
            default:
                return [symptomColor]
            }
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
}

// MARK: - IB Actions

extension CalendarViewController {
    
    
    @IBAction func addNewRecord(sender: UIButton) {
        
    }
    
    @IBAction func showRecords(sender: UIButton) {
        
    }
    
    // CVCalendar Methods
    
//    @IBAction func switchChanged(sender: UISwitch) {
//        if sender.on {
//            calendarView.changeDaysOutShowingState(false)
//            shouldShowDaysOut = true
//        } else {
//            calendarView.changeDaysOutShowingState(true)
//            shouldShowDaysOut = false
//        }
//    }
//    
//    @IBAction func todayMonthView() {
//        calendarView.toggleCurrentDayView()
//    }
//
//    /// Switch to WeekView mode.
//    @IBAction func toWeekView(sender: AnyObject) {
//        calendarView.changeMode(.WeekView)
//    }
//    
//    /// Switch to MonthView mode.
//    @IBAction func toMonthView(sender: AnyObject) {
//        calendarView.changeMode(.MonthView)
//    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        self.currentMonthDate = self.currentMonthDate.dateByAddingMonths(-1)!
        //currentMonthRecordsList = RegistryServices.getRegistryListFromCurrentMonth(self.currentMonthDate)
        updateMonthList()
        
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        self.currentMonthDate = self.currentMonthDate.dateByAddingMonths(1)!
        //currentMonthRecordsList = RegistryServices.getRegistryListFromCurrentMonth(self.currentMonthDate)
        updateMonthList()
        
        calendarView.loadNextView()
    }
}


