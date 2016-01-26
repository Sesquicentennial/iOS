//
//  LandmarkDetailVC.swift
//  Carleton150

import Foundation

import UIKit

class LandmarkDetailVC: UIViewController, UIPopoverPresentationControllerDelegate{
    var nameText: String = "name"
    var descriptionText: String = "description"
    
    @IBOutlet var Button: UIView!
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkDescription: UILabel!
    
    func setTextFields() {
        self.landmarkDescription.text = nameText
        self.landmarkName.text = descriptionText
    }
    
    @IBAction func triggerMap(sender: AnyObject) {
        self.performSegueWithIdentifier("mapView", sender: nil)
    }
    

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.FullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.setTextFields()
    }
    
}