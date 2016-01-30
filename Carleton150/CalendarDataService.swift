//
//  CalendarDataService.swift
//  Carleton150

import Foundation
import Alamofire
import SwiftyJSON

/// Data Service that contains relevant endpoints for the Calendar module.
final class CalendarDataService {
    
    /**
        Request events for the calendar.
     
        - Parameters:
            - completion: function that will perform the behavior
                          that you want given a list with all the events
                          from the server.
     
            - limit:      A hard limit on the amount of quests returned
                          by the server.
     
            - date:       The earliest date from which to get data.
     
     */
    class func requestEvents(date: NSDate?, limit: Int, completion:
        (success: Bool, result: [Dictionary<String, String>]?) -> Void) {
            
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
           
        var dateString : String = ""
        if let desiredDate = date {
            dateString = dateFormatter.stringFromDate(desiredDate)
        } else {
            let todaysDate = NSDate()
            dateString = dateFormatter.stringFromDate(todaysDate)
        }

        let parameters = [
            "startTime": dateString,
            "limit": limit
        ]
        
        Alamofire.request(.POST, Endpoints.calendar, parameters: (parameters as! [String : AnyObject]), encoding: .JSON).responseJSON() {
            (request, response, result) in
            
            var events : [Dictionary<String, String>] = []
            
            if let result = result.value {
                let json = JSON(result)
                if let answer = json["content"].array {
                    for i in 0 ..< answer.count {
                        let title = answer[i]["title"].string!
                        let description = answer[i]["description"].string!
                        let location = answer[i]["location"].string!
                        let startTime = CalendarDataService.parseDate(answer[i]["startTime"].string!)
                        let duration = answer[i]["duration"].string!
                        let event = ["title": title,
                                     "description": description,
                                     "location": location,
                                     "startTime": startTime,
                                     "duration": duration]
                        events.append(event)
                    }
                    completion(success: true, result: events)
                } else {
                    print("No results were found.")
                    completion(success: false, result: nil)
                }
            } else {
                print("Connection to server failed.")
                completion(success: false, result: nil)
            }
        }
    }
    
    /**
        Parses datestrings from iCal objects.
     
        - Parameters:
            - date: The datestring from the server.
     
        - Returns: A more easily readable start time and date.
     
     */
    private class func parseDate(dateString: String) -> String {
        
        let inFormatter = NSDateFormatter()
        let outFormatter = NSDateFormatter()
        outFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        outFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        if dateString == "No Time Available" {
            return ""
        } else if dateString.contains("T") {
            inFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
            let calendarDate: NSDate = inFormatter.dateFromString(dateString)!
            return outFormatter.stringFromDate(calendarDate)
        } else {
            inFormatter.dateFormat = "yyyy'-'MM'-'dd"
            let calendarDate: NSDate = inFormatter.dateFromString(dateString)!
            return outFormatter.stringFromDate(calendarDate)
        }
    }
}