//
//  ViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

struct list {
    var workshop: [activity]
    var tasks: [activity]
    
    init() {
        workshop = [activity]()
        tasks = [activity]()
    }
}

struct activity {
    var name:String
    var description:String
    var required_badges: [String]
    var adquired_badgers: [String]
}

var activityList = list()

class ListViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.google.ca")!
        
        _ = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonResult)
                }
                catch{
                    print("JSON Failed")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = activityList.tasks[indexPath.row].name
        
        return cell
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            //add code here for when you hit delete
//            toDolist.removeAtIndex(indexPath.row)
//            NSUserDefaults.standardUserDefaults().setObject(toDolist, forKey: "list")
//            tableView.reloadData()
//        }
//    }


}

