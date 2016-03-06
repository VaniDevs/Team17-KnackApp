//
//  DataManager.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-06.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import Foundation

// Public Data
var badgeRepository = [Int : badge]()
var currentUser = user()
var activityList = List()
let dataManager = DataManager()

struct badge {
    var img: String
    var name: String
    
    init(inputImg: String, inputName: String){
        img = inputImg
        name = inputName
        
    }
}

struct user {
    var name: String
    var location: String
    var id: Int
    var badges: [Int]
    var img: String
    var contact: String
    
    init(){
        name = ""
        location = ""
        id = 0
        badges = [1]
        img = ""
        contact = ""
    }
    
    init(inputName: String, inputLocation: String, inputId: Int, inputBadges: [Int], inputImg: String, inputContact:String){
        name = inputName
        location = inputLocation
        id = inputId
        badges = inputBadges
        img = inputImg
        contact = inputContact
    }
}


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
//                    print(activity.toString())
                }
            }
            
            if let tasks = objects["tasks"] as! NSArray? {
                for node in tasks {
                    let activity = Activity.init(input: node as! NSDictionary)
                    self.tasks.append(activity)
//                    print(activity.toString())
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
    var timeStamp:String = ""
    var employer:String = ""
    var location:String = ""
    var contact:String = ""
    var required_badges =  NSArray()
    var awarded_badges = NSArray()
    
    override init() {
        name = ""
        activity_desc = ""
        timeStamp = ""
        employer = ""
        location = ""
        contact = ""
    }
    
    init ( input: NSDictionary ){
        name = input["name"] as! String
        activity_desc = input["description"] as! String
        timeStamp = input["timestamp"] as! String
        employer = input["employer"] as! String
        location = input["location"] as! String
        contact = input["contact"] as! String
        
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

class DataManager: NSObject {
    
    var initialized = false
    
    func loadEarnerInfo(callback: (()->Void)? ){
        print("Loading user info...")
        let url = NSURL(string: "https://quiet-temple-44406.herokuapp.com/earners")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let earnersArray = jsonResult["earners"] as! NSArray? {
                        let earner = earnersArray[0]

                        currentUser.name = earner["name"] as! String
                        currentUser.location = earner["location"] as! String
                        currentUser.id = earner["id"] as! Int
                        currentUser.img = earner["img"] as! String
                        currentUser.contact = earner["contact"] as! String
                        currentUser.badges = earner["badges"] as! [Int]
                    }
                    callback!()
                }
                catch{
                    print("JSON Failed")
                }
            }
        }
        
        task.resume()
    }
    
    func createBadgeDB(){
        print("Creating badge repo...")
        let url = NSURL(string: "https://quiet-temple-44406.herokuapp.com/badges")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let badgesArray = jsonResult["badges"] as! NSArray? {
                        for item in badgesArray{
                            badgeRepository[item["id"] as! Int] = badge(inputImg: item["img"] as! String, inputName: item["name"] as! String)
                        }
                        
                    }
                    
                }
                catch{
                    print("JSON Failed")
                }
            }
        }
        
        task.resume()
        
    }
    
    
    func createActivities(){
        print("Creating activities...")
        let url = NSURL(string: "https://quiet-temple-44406.herokuapp.com/activities")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    activityList.createList(jsonResult, callback: nil)
                }
                catch{
                    print("JSON Failed")
                }
            }
        }
        
        task.resume()
        
        
    }
    
    
}



