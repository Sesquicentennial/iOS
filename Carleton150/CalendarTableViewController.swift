//
//  CalendarTableViewController.swift
//  Carleton150
//
//  Created by Sherry Gu on 2/16/16.
//  Copyright © 2016 edu.carleton.carleton150. All rights reserved.
//

import Foundation
import UIKit

class CalendarTableViewController: UITableViewController {
    
    var calendar: [Dictionary<String, String>] = []
    var cells: [CalendarCell] = []
    var eventImages: [UIImage] = []
    var tableLimit : Int!
    var datePickerHidden = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add bottom border to the timeline title
                // set the dataSource and delegate for the timeline table
        tableView.dataSource = self
        tableView.delegate = self
       
        
        // set properties on the navigation bar
        Utils.setUpNavigationBar(self)
        
        // set the title
        // set a default row height
        tableView.estimatedRowHeight = 500.0
        // stop the navigation bar from covering the calendar content
        self.navigationController!.navigationBar.translucent = false;
        
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCalendarDetail") {
            let detailViewController = (segue.destinationViewController as! CalendarDetailView)
            detailViewController.parentView = self
            detailViewController.setData(sender as! CalendarCell)
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
 
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 200.0
        }
        else if indexPath.section == 1{
            return 500.0
        }
        else{
            return 1000.0
        }
    }
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("dequeueuing")
        if indexPath.section == 0{
            let cell: currentDate = tableView.dequeueReusableCellWithIdentifier("currentDate", forIndexPath: indexPath) as! currentDate
            //cell.date.text = "today"
            
            print("the first cell")
            return cell
        }
        else if indexPath.section == 1{
            
            let cell: datePicker = tableView.dequeueReusableCellWithIdentifier("datePicker", forIndexPath: indexPath) as! datePicker
            print("the second cell")
            return cell
            

        }
        else{
            let cell: collections = tableView.dequeueReusableCellWithIdentifier("collections", forIndexPath: indexPath) as! collections
            print("the third cell")
            
            
            
            return cell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker()
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 1{
            return 0
        }
        else {
            if indexPath.section == 0{
                return 20
            }
            else if indexPath.section == 1{
                return 100.0
            }
            else{
                return 1000.0
            }
        }
    }
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    /**
     Determines the number of cells in the table view.
     
     - Parameters:
     - tableView: The table view being used for the timeline.
     
     - section: The current section of the table view.
     
     - Returns: The number of historical events for the triggered geofence.
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func badConnection(limit: Int, date: NSDate) {
        let alert = UIAlertController(title: "Bad Connection", message: "You seemed to have trouble connecting to our server. Try again?", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction1 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) {
            (UIAlertAction) -> Void in
            // do nothing for now.
        }
        let alertAction2 = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) {
            (UIAlertAction) -> Void in
            // TODO: Fix how this works.
        }
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        self.presentViewController(alert, animated: true) { () -> Void in }
    }

}





