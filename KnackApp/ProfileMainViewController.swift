//
//  ProfileMainView.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import Foundation
import UIKit

var openWorkshop = true

class ProfileMainViewController: UIViewController, UITableViewDelegate {
    
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swipe Controls
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "changeView:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight) // Add to the object that is going to recognize
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "changeView:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeUp) // Add to the object that is going to recognize
        
    
    }
    
    func changeView (gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                openWorkshop = false
            case UISwipeGestureRecognizerDirection.Left:
                openWorkshop = true
            default:
                break
            }
            performSegueWithIdentifier("swipeSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    //-------Defaults-----------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}