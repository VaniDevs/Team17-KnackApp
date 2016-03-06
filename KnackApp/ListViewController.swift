//
//  ViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
//    var activityList = List()
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if openWorkshop {
            navBarTitle.title = "Workshops"
        } else {
            navBarTitle.title = "Tasks"
        }
        
//        let url = NSURL(string: "https://quiet-temple-44406.herokuapp.com/activities")!
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
//            if let urlContent = data {
//                do {
//                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
//                    self.activityList.createList(jsonResult, callback: { () -> Void in
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            self.tableView.reloadData()
//                        })
//                    })
//                }
//                catch{
//                    print("JSON Failed")
//                }
//            }
//        }
//        
//        task.resume()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
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
            cell.address.text = activityList.workshop[indexPath.row].location
            cell.timeStamp.text = activityList.workshop[indexPath.row].timeStamp
        } else {
            cell.address.text = activityList.tasks[indexPath.row].location
            cell.timeStamp.text = activityList.tasks[indexPath.row].timeStamp
            cell.orgName.text = activityList.tasks[indexPath.row].name
        }
        
        // TODO: Map images
        cell.orgIcon.image = UIImage(named: "mc")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let activityView = sb.instantiateViewControllerWithIdentifier("activity")
        as! ActivityViewController
        
        activityView.activity = activityList.workshop[indexPath.row]
        
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

