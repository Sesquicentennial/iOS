//
//  DatePickerVC.swift
//  Carleton150
//
//  Created by jeffcomps on 2/20/16.
//  Copyright © 2016 edu.carleton.carleton150. All rights reserved.
//

import Foundation
import UIKit

class DatePickerVC: UIViewController {
    var parentView : CollectionAndBarVC!
    
    override func viewDidLoad() {}
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func changeDate(sender: AnyObject) {
        //print(datePicker.date)
        parentView.dateFromPicker = datePicker.date
        print("About to post")
        NSNotificationCenter.defaultCenter().postNotificationName("changeDates", object: self)
        parentView.dismissViewControllerAnimated(true) { () -> Void in }
    }
    
    
    @IBAction func exitPickerView(sender: UIButton) {
    }
    
    
}