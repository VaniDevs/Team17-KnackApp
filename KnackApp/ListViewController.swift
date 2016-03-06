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
    
    var activityList = List()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib:UINib = UINib(nibName: "ActivityTableViewCell", bundle: NSBundle.mainBundle())        
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
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
        return activityList.workshop.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell") else {return UITableViewCell()}
        
          let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ActivityTableViewCell
        
        cell.organizationName.text = activityList.workshop[indexPath.row].name
        
        return cell
    }
    
    //-------Actions----

    @IBAction func showTasks(sender: AnyObject) {
        print("Reload table")
        tableView.reloadData()
    }
    
    //-------Defaults-----------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

