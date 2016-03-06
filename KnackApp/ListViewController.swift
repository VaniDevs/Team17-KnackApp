//
//  ViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import Foundation
import UIKit

class List: NSObject {
    var workshop: [Activity]
    var tasks: [Activity]
    
    override init() {
        workshop = [Activity]()
        tasks = [Activity]()
    }
    
    func createList(list: AnyObject? , callback: (() ->Void)?) {
        
        if let objects = list {
            if let workshops = objects["workshops"] as! NSArray? {
                for node in workshops {
                    let activity = Activity.init(input: node as! NSDictionary)
                    self.workshop.append(activity)
                    print(activity.toString())
                }
            }
            
            if let tasks = objects["tasks"] as! NSArray? {
                for node in tasks {
                    let activity = Activity.init(input: node as! NSDictionary)
                    self.tasks.append(activity)
                    print(activity.toString())
                }
            }
        }
        if let callback = callback {
            callback()
        }
    }
}

class Activity: NSObject {
    var name:String = ""
    var activity_desc:String = ""
    var required_badges =  NSArray()
    var awarded_badges = NSArray()
    
    init ( input: NSDictionary ){
        name = input["name"] as! String
        activity_desc = input["description"] as! String
        if input["required_badges"] != nil {
            required_badges = input["required_badges"] as! NSArray
        }
        if input["awarded_badges"] != nil {
            awarded_badges = input["awarded_badges"] as! NSArray
        }
    }
    
    func toString() -> String {
        return self.name + " : " + self.activity_desc
    }
}


class ListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    var activityList = List()
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if openWorkshop {
            navBarTitle.title = "Workshops"
        } else {
            navBarTitle.title = "Tasks"
        }
        
        let url = NSURL(string: "https://quiet-temple-44406.herokuapp.com/activities")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    self.activityList.createList(jsonResult, callback: { () -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                    })
                }
                catch{
                    print("JSON Failed")
                }
            }
        }
        
        task.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return openWorkshop ? activityList.workshop.count : activityList.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        if openWorkshop {
            cell.orgName.text = activityList.workshop[indexPath.row].name
            cell.address.text = "4911 W Road, Vancouver, BC"
        } else {
            cell.address.text = "4911 W Road, Vancouver, BC"
            cell.orgName.text = activityList.tasks[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let activityView = sb.instantiateViewControllerWithIdentifier("activity")
        as! ActivityViewController
        //Pass info
        activityView.test = "Test"
        activityView.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(activityView, animated: true, completion: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "back"{
            openWorkshop = !openWorkshop
        
            // this gets a reference to the screen that we're about to transition to
            let toViewController = segue.destinationViewController as UIViewController
        
            // instead of using the default transition animation, we'll ask
            // the segue to use our custom TransitionManager object to manage the transition animation
            toViewController.transitioningDelegate = self.transitionManager
        }
        
        
        
    }
    
    //-------Defaults-----------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

