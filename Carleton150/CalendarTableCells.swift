//
//  CalendarTableCells.swift
//  Carleton150
//
//  Created by Sherry Gu on 2/16/16.
//  Copyright © 2016 edu.carleton.carleton150. All rights reserved.
//

import Foundation
var curDate: String!

class currentDate: UITableViewCell{
    @IBOutlet weak var date: UILabel!
    
    func setDate(){
        date.text = curDate
    }
}

class datePicker: UITableViewCell{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerAction(sender: UIDatePicker) {
        datePickerChanged()
    }
    func datePickerChanged(){
        curDate = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
}

class collections:UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate
{
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var calendar: [Dictionary<String, String>] = []
    var cells: [CalendarCell] = []
    var eventImages: [UIImage] = []
    var tableLimit : Int!
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //view.backgroundColor = UIColor(red: 252, green: 212, blue: 80, alpha: 1.0)
        self.collectionView.backgroundColor = UIColor(red: 224, green: 224, blue: 224, alpha: 1.0)
        
        // set the deceleration rate for the event cell snap
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateFast

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCell")
       
        
        self.contentView.addSubview(collectionView)
    }
    
    required init?(coder decoder : NSCoder) {
        super.init(coder: decoder)
        
        NSNotificationCenter
            .defaultCenter()
            .addObserver(self, selector: "actOnCalendarUpdate:", name: "carleton150.calendarUpdate", object: nil)
        
    }
    

    
    /**
     Gets the image backgrounds for the calendar.
     
     - Returns: A list of UIImage backgrounds to place in the collection view.
     */
    func getEventImages() -> [UIImage] {
        for i in 1 ..< 11 {
            let eventImage = UIImage(named: "Event-" + String(i))
            if let eventImage = eventImage {
                eventImages.append(eventImage)
            }
        }
        return eventImages
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90) // The size of one cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(collectionView.frame.width, 90)  // Header size
    }
    
    /**
     Upon noticing that the calendar has been updated,
     update the UI accordingly.
     
     - Parameters:
     - notification: The notification triggered from the CalendarDataService.
     */
    func actOnCalendarUpdate(notification: NSNotification) {
        if let calendar = CalendarDataService.schedule {
            print("received notification")
            
            self.calendar = calendar
            let indexPath = NSIndexPath(forItem: 0, inSection: 0)
            let _ = CalendarDetailView()
            let _ = self.collectionView
                .dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! CalendarCell
        }
    }
    
    /**
     Determines the number of sections in the calendar collection view.
     
     - Parameters:
     - collectionView: The collection view being used for the calendar.
     */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /**
     Determines the number of cells in the calendar collection view.
     
     - Parameters:
     - collectionView:         The collection view being used for the calendar.
     
     - numberOfItemsInSection: The number of items in the calendar.
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.count
    }
    
    
    
    /**
     Animates a section of the calendar to focus at the top of the page on tap.
     
     - Parameters:
     - collectionView: The collection view being used for the calendar.
     
     - indexPath:      The index of the cell that was clicked.
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = UICollectionViewFlowLayout() as! CalendarLayout
//        
        collectionView.collectionViewLayout = layout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
    
    
    /**
     Fills each section of the calendar with data as they are loaded into the view.
     
     - Parameters:
     - collectionView: The collection view being used for the calendar.
     
     - indexPath:      The index of the current cell.
     
     - Returns: A built calendar cell.
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! CalendarCell
        let images = getEventImages()
        let eventText = calendar[indexPath.item]["title"]
        cell.eventTitle.text = eventText
        cell.currentImage = images[indexPath.item % 10]
        cell.locationLabel.text = calendar[indexPath.item]["location"]!
        cell.timeLabel.text = calendar[indexPath.item]["startTime"]!
        cell.eventDescription = calendar[indexPath.item]["description"]!
        return cell
    }
}