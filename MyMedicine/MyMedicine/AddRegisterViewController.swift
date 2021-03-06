//
//  AddRegisterViewController.swift
//  MyMedicine
//
//  Created by Jheniffer Jordao Leonardi on 8/28/15.
//  Copyright (c) 2015 MedCare. All rights reserved.
//

import UIKit

class AddRegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var datePickerAction: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets current date to selectedLabel
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let currentDate = NSDate()
        var strDate = dateFormatter.stringFromDate(currentDate)
        self.selectedDate.text = strDate

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
        self.selectedDate.text = strDate
        
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

}
