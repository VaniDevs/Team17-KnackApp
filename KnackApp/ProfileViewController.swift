//
//  ProfileViewController.swift
//  KnackApp
//
//  Created by Joohan Oh on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

var id1:Int = 1
var id2:Int = 2
var id3:Int = 3
let photo1 = "ss_badge1"
let photo2 = "hs_badge2"
let photo3 = "hs_badge3"

struct profile {

     var   name = "Andrew"
     var   address = "#109 Walter Gage Rd."
     var   email = "joohan0311@hotmail.com"
     var   badges = [id1, id3]
	
}

var person = profile()


var badgeStore = [id1:photo1, id2:photo2, id3:photo3]

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photosOfBadges = [UIImage]()
    var listOfBadges = [person.badges]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load badges
//        loadBadges()
        
     
    }
    
    
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
    
    // MARK: TableViewController
        
        // MARK: properties
    
    
        
        // MARK: - Table view data source
        
         func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
         func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return photosOfBadges.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // Table view cells are reused and should be dequeued using a cell identifier.
            let cellIdentifier = "BadgeTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BadgeTableViewCell
            
            // Fetches the appropriate meal for the data source layout.
            let badge = listOfBadges[indexPath.row]
//            cell.imageView?.image = UIImage(named: badgeStore[badge])
            
//            for value in badge.values {
//                cell.imageView?.image = value
//            }
            
            return cell
        }
    //}
}
