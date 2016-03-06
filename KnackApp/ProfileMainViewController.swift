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

class ProfileMainViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
    
    override func viewWillAppear(animated: Bool) {
        if !dataManager.initialized {
            dataManager.loadEarnerInfo { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.nameLabel.text = currentUser.name
                    self.email.text = currentUser.contact
                    self.addressLabel.text = currentUser.location
                    self.tableView.reloadData()
                })
            }
            dataManager.createBadgeDB()
            dataManager.createActivities()
            dataManager.initialized = true
        } else {
            self.nameLabel.text = currentUser.name
            self.email.text = currentUser.contact
            self.addressLabel.text = currentUser.location
        }
        
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
    
    //-------Profile Pic-----------
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    //------Badges Table --------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.badges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeTableViewCell
        
        let badgeImg = badgeRepository[currentUser.badges[indexPath.row]]!.img

        cell.badgeImg.image = UIImage(named: badgeImg)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let activityView = sb.instantiateViewControllerWithIdentifier("badge detail")
            as! BadgeViewController
        let badgeItem = badgeRepository[currentUser.badges[indexPath.row]]!
        
        activityView.badgeInfo = badge(inputImg: badgeItem.img, inputName: badgeItem.name, inputDescription: badgeItem.description)
        activityView.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(activityView, animated: true, completion: nil)
        
        
    }
    
    
    //-------Defaults-----------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}