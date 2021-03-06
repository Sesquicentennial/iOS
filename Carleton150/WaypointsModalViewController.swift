//
//  WaypointsModalViewController.swift
//  Carleton150

import UIKit

class WaypointsModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var parentVC: QuestPlayingViewController!
	var waypoints = [WayPoint]()
	
	@IBOutlet weak var titleView: UIView!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var titleLabel: UILabel!

	override func viewDidLoad() {
		
		// set transparency
		self.view.backgroundColor = UIColor(white: 0, alpha: 0.6)

		// add bottom border to the timeline title
		titleView.addBottomBorderWithColor(UIColor(white: 0.9, alpha: 0.95), width: 1.5)
		
		// set the dataSource and delegate for the timeline table
		tableView.dataSource = self
		tableView.delegate = self
		
		// set a default row height
		tableView.estimatedRowHeight = 160.0
		
		titleLabel.text = "Completed Waypoints"
	}
	
	/**
		Upon clicking outside the modal view or on the X button,
		dismiss the view.
		
		- Parameters:
			- sender: The UI element that triggered the action.
	*/
	@IBAction func dismissAction(sender: AnyObject) {
		parentVC.dismissViewControllerAnimated(true)  {() -> Void in }
	}
	
	/**
	
		Table UITableViewDataSource methods
	
	*/

	/**
		Determines the number of sections in the table view.
		
		- Parameters:
			- tableView: The table view being used for the timeline.
		
		- Returns: the total number of waypoints
	*/
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return waypoints.count
	}
	
	/**
		Determine the number of cells in each section. Each section is defined as a waypoint. If the waypoint
		has a completion message, the section has three cells. Otherwise, it has two cells (for clue and hint)
	
	  	- Parameters:
			- tableView: The table view being used for the modal.
			
			- section: The current section of the table view.
			
		- Returns: The number of cells for the waypoint in question
	*/
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// if custom completion message
		if let _ = waypoints[section].completion["text"] as! String! {
			return 3
		}
		// else just hint and clue
		return 2
	}
	
	/**
		Determines the of each of the cells in the table view by using autolayout to determine the cell height.
		
		- Parameters:
			- tableView: The table view being used for the modal.
		
			- indexPath: The current cell index of the table view.
		
		- Returns: The calculated height of the table view cell.
	*/
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	/**
		Adds data to each of the cells in the table view. Each section can have three possible type of cells: 
		clues, hints, and completion. The assignment of these types to integers is arbitrary
		
		- Parameters:
			- tableView: The table view being used for the timeline.
			
			- indexPath.section: The current section index
	
			- indexPath.row: The current cell index within each each
		
		- Returns: The modified table view cell.
	*/
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let waypoint = waypoints[indexPath.section]
		// clue
		if (indexPath.row == 0) {
			if let clueImg = waypoint.clue["image"] as! String! {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableImageCell", forIndexPath: indexPath) as! WaypointTableImageCell
				cell.cellImage = UIImage(data: NSData(base64EncodedString: clueImg, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!)
				cell.titleText = "Clue"
				cell.descText = waypoint.clue["text"] as? String
				return cell
			} else {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableTextCell", forIndexPath: indexPath) as! WaypointTableTextCell
				cell.titleText = "Clue"
				cell.descText = waypoint.clue["text"] as? String
				cell.setCellViewTraits()
				return cell
			}
		// hint
		} else if (indexPath.row == 1) {
			if let hintImg = waypoint.hint["image"] as! String! {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableImageCell", forIndexPath: indexPath) as! WaypointTableImageCell
				cell.cellImage = UIImage(data: NSData(base64EncodedString: hintImg, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!)
				cell.titleText = "Hint"
				cell.descText = waypoint.hint["text"] as? String
				return cell
			} else {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableTextCell", forIndexPath: indexPath) as! WaypointTableTextCell
				cell.titleText = "Hint"
				cell.descText = waypoint.hint["text"] as? String
				cell.setCellViewTraits()
				return cell
			}
		} else if (indexPath.row == 2) {
			if let compImg = waypoint.completion["image"] as! String! {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableImageCell", forIndexPath: indexPath) as! WaypointTableImageCell
				cell.cellImage = UIImage(data: NSData(base64EncodedString: compImg, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!)
				cell.titleText = "Completion"
				cell.descText = waypoint.completion["text"] as? String
				return cell
			} else {
				let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableTextCell", forIndexPath: indexPath) as! WaypointTableTextCell
				cell.titleText = "Completion"
				cell.descText = waypoint.completion["text"] as? String
				cell.setCellViewTraits()
				return cell
			}
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier("WaypointTableTextCell", forIndexPath: indexPath) as! WaypointTableTextCell
		cell.titleText = ""
		cell.descText = "Couldn't find data for waypoint"
		cell.setCellViewTraits()
		return cell
	}
	
	
}
