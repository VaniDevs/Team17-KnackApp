//
//  TaskViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-06.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var orgIcon: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var activity_desc: UILabel!
    
    var activity:Activity = Activity()
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onApply(sender: AnyObject) {
        print("Applied")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        orgIcon.image = UIImage(named: activity.employer)
        activityName.text = activity.name
        location.text = activity.location
        date.text = activity.timeStamp
        activity_desc.text = activity.activity_desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----Badge Table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.required_badges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeTableViewCell
        
        let badgeImg = badgeRepository[activity.required_badges[indexPath.row] as! Int]!.img
        
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
    
    

}
