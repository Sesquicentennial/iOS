//
//  CalenderView.swift
//  Carleton150
//
//  Created by Sherry Gu on 1/12/16.
//  Copyright © 2016 edu.carleton.carleton150. All rights reserved.
//

import Foundation

class CalenderView: UIViewController{
    @IBOutlet weak var events: UILabel!
    var schedule=["Jan 13th \r","Jan 14th \r", "Jan 15th \r"]
    override func viewDidLoad() {
        events.text = ""
        //allow newline 
        events.numberOfLines = 0;
        for day in schedule {
            print(day)
            events.text = events.text! + day
            
        }
        print(events.text)
        
    }
}