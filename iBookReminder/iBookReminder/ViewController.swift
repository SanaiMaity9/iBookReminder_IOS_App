//
//  ViewController.swift
//  Rating Demo
//
//  Created by Glen Yi on 2014-09-05.
//  Copyright (c) 2014 On The Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FloatRatingViewDelegate {
    
    
    @IBOutlet var abc: UIView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var liveLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    var  k:NSNumber!
    struct defaultsKeys {
        static let bkid = "bki"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //** database coding for rating 
        
        
        
        
        
        //
        /** Note: With the exception of contentMode, all of these
            properties can be set directly in Interface builder **/
        ratingSegmentedControl.hidden = true
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "2")
        self.floatRatingView.fullImage = UIImage(named: "3")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 0.0
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = false
        self.floatRatingView.floatRatings = true
        
        // Segmented control init
        self.ratingSegmentedControl.selectedSegmentIndex = 2
        
        // Labels init
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ratingTypeChanged(sender: UISegmentedControl) {
        self.floatRatingView.halfRatings = sender.selectedSegmentIndex==1
        self.floatRatingView.floatRatings = sender.selectedSegmentIndex==2
    }

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
  
    @IBAction func `do`(sender: AnyObject) {
        let vc = CustomAlertViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
}