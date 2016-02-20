//
//  utils.swift
//  Carleton150

import Foundation
import Darwin
import GoogleMaps

/// A class for utility functions that are required for multiple views.
final class Utils {
    
    /**
        Finds the distance (in meters) between two
        latitude and longitude coordinates.

        - Parameters:
            - point1: First coordinate.
            - point2: Second coordinate.

        - Returns: The distance (in meters) between the two points.
     */
    class func getDistance(point1: CLLocationCoordinate2D, point2: CLLocationCoordinate2D) -> Double {
        let radius: Double = 6378137
        let Φ_1 = degreesToRadians(point1.latitude)
        let Φ_2 = degreesToRadians(point2.latitude)
        let ΔΦ = degreesToRadians(point1.latitude - point2.latitude)
        let ΔΛ = degreesToRadians(point1.longitude - point2.longitude)
        let a = sin(ΔΦ / 2) * sin(ΔΦ / 2) +
                cos(Φ_1) * cos(Φ_2) *
                sin(ΔΛ / 2) * sin(ΔΛ / 2)
        return (2 * atan2(sqrt(a), sqrt(1 - a))) * radius
    }
    
    /**
        Performs a degree to radian conversion.

        - Parameters:
            - degrees: Quantity (in degrees) to convert.

        - Returns: The equivalent radian quantity for a given number of degrees.
     */
    private class func degreesToRadians(degrees: Double) -> Double {
        return degrees * M_PI / 180
    }
    
    
    class func setUpTiling(currentMap: GMSMapView) {
        // Implement GMSTileURLConstructor
        // Returns a Tile based on the x, y, zoom coordinates
        let urlsBase = { (x: UInt, y: UInt, zoom: UInt) -> NSURL in
            let url = "https://www.carleton.edu/global_stock/images/campus_map/tiles/base/\(zoom)_\(x)_\(y).png"
            
            return NSURL(string: url)!
        }
        let urlsLabel = { (x: UInt, y: UInt, zoom: UInt) -> NSURL in
            let url = "https://www.carleton.edu/global_stock/images/campus_map/tiles/labels/\(zoom)_\(x)_\(y).png"
            
            return NSURL(string: url)!
        }
        
        // Create the GMSTileLayer
        let layerBase = GMSURLTileLayer(URLConstructor: urlsBase)
        let layerLabel = GMSURLTileLayer(URLConstructor: urlsLabel)
        
        // Display on the map at a specific zIndex
        //Labels should go on top
        layerBase.zIndex = 0
        layerBase.tileSize = 256
        layerBase.map = currentMap
        layerLabel.zIndex = 1
        layerLabel.tileSize = 256
        layerLabel.map = currentMap
    }
    
    /**
        Shows the Carleton logo and sets the translucency of 
        the top navigation bar in the designated view.
     */
    class func setUpNavigationBar(currentController: UIViewController) {
        
        // shows the Carleton logo on the navigation bar
        let logo = UIImage(named: "carleton_logo.png")
        let imageView = UIImageView(image:logo)
        currentController.navigationItem.titleView = imageView
        
        // stop the navigation bar from covering the calendar content
        currentController.navigationController!.navigationBar.translucent = false;
    }
    
    class func filterCalendarData(calendar: [Dictionary<String, String>], chosenDate: String) -> [Dictionary<String, String>] {
        var specificDay: [Dictionary<String, String>] = []
        for i in 0 ..< calendar.count{
            let curDay = String(calendar[i]["startTime"])
            let date = curDay.substringWithRange(Range<String.Index>(start: curDay.startIndex.advancedBy(14), end: curDay.startIndex.advancedBy(16)))
            let month = curDay.substringWithRange(Range<String.Index>(start: curDay.startIndex.advancedBy(10), end: curDay.startIndex.advancedBy(13)))
            let year = curDay.substringWithRange(Range<String.Index>(start: curDay.startIndex.advancedBy(18), end: curDay.startIndex.advancedBy(22)))
            let chosendate = chosenDate.substringWithRange(Range<String.Index>(start: chosenDate.startIndex.advancedBy(7), end: chosenDate.startIndex.advancedBy(9)))
            let chosenMonth = chosenDate.substringWithRange(Range<String.Index>(start: chosenDate.startIndex.advancedBy(4), end: chosenDate.startIndex.advancedBy(7)))
            let chosenYear = chosenDate.substringWithRange(Range<String.Index>(start: chosenDate.startIndex.advancedBy(0), end: chosenDate.startIndex.advancedBy(4)))
          
            if date == chosendate && month == chosenMonth && year == chosenYear {
                
                specificDay.append(calendar[i])
                
            }
            
        }
        
        return specificDay
            
    }
    
}
