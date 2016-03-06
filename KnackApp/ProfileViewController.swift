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
//ADD
let reuseIdentifier = "badgeCell" // also enter this string as the cell identifier in the storyboard

//ADD UICollectionViewDelegate
class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    //ADD
    //@IBOutlet weak var cellView: UICollectionView!
    
    
    var photosOfBadges = [UIImage]()
    var listOfBadges = [person.badges]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load badges
        photosOfBadges = [
            UIImage(named: "ss_badge1")!,
            UIImage(named: "ss_badge2")!,
            UIImage(named: "ss_badge3")!,
            UIImage(named: "ss_badge4")!,
            UIImage(named: "ss_badge5")!,
            UIImage(named: "ss_badge6")!,
            UIImage(named: "ss_badge1")!,
            UIImage(named: "ss_badge2")!,
            UIImage(named: "ss_badge3")!,
            UIImage(named: "ss_badge4")!,
            UIImage(named: "ss_badge5")!,
            UIImage(named: "ss_badge6")!,
            UIImage(named: "ss_badge1")!,
            UIImage(named: "ss_badge2")!,
            UIImage(named: "ss_badge3")!,
            UIImage(named: "ss_badge4")!,
            UIImage(named: "ss_badge5")!,
            UIImage(named: "ss_badge6")!
        ]
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
    
    //ADD
    // MARK: CollectionViewCellController
        
        // MARK: properties
    
    func numberOfSectionsInCollectionView(collectionView:
        UICollectionView!) -> Int {
            return 1
    }
    func collectionView(collectionView: UICollectionView!,
        numberOfItemsInSection section: Int) -> Int {
            return photosOfBadges.count
    }
    
    func collectionView(collectionView: UICollectionView!,
        cellForItemAtIndexPath indexPath: NSIndexPath!) ->
        UICollectionViewCell! {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
            forIndexPath: indexPath) as! BadgeCollectionViewCell
            //cell.backgroundColor = UIColor.redColor()
            
//          // Configure the cell
            let image = photosOfBadges[indexPath.row]
            cell.badgeImg.image = image
            return cell
    }
}
