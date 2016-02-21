//
//  CollectionAndBarVC.swift
//  Carleton150
//
//  Created by jeffcomps on 2/20/16.
//  Copyright © 2016 edu.carleton.carleton150. All rights reserved.
//

import Foundation
import UIKit

class CollectionAndBarVC: UIViewController {
    
    var dateFromPicker : NSDate!
    
    required init?(coder decoder : NSCoder) {
        super.init(coder: decoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeDates:", name: "changeDates", object: nil)
    }
    
    override func viewDidLoad() {
        Utils.setUpNavigationBar(self)
        self.navigationController!.navigationBar.translucent = false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCalendarDetail") {
            let detailViewController = (segue.destinationViewController as! CalendarDetailView)
            detailViewController.parentView = self
            detailViewController.setData(sender as! CalendarCell)
        }
        if (segue.identifier == "segueToContainer") {
            print("Doing the container segue")
            let collectionViewController = (segue.destinationViewController as! CalendarViewController)
            collectionViewController.parentView = self
            //collectionViewController.setData(sender as! CalendarCell)
            NSNotificationCenter.defaultCenter().postNotificationName("carleton150.calendarUpdate", object: self)
            //collectionViewController.calendar=CalendarDataService.schedule!
            //collectionViewController.actOnCalendarUpdate()
        }
        if (segue.identifier == "toDatePicker") {
            print("Doing the container segue")
            let datePicker = (segue.destinationViewController as! DatePickerVC)
            datePicker.parentView = self
            //collectionViewController.setData(sender as! CalendarCell)
            //NSNotificationCenter.defaultCenter().postNotificationName("carleton150.calendarUpdate", object: self)
            //collectionViewController.calendar=CalendarDataService.schedule!
            //collectionViewController.actOnCalendarUpdate()
        }
        

    }
    
    func changeDates(notification: NSNotification) {
        print(dateFromPicker)
    }
    
}