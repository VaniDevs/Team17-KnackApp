//
//  ActivityViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var orgIcon: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var earnedBadge: UIImageView!
    @IBOutlet weak var activity_desc: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    
    var activity:Activity = Activity()
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onRegister(sender: AnyObject) {
        showAlert("Registered")
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
        earnedBadge.image = UIImage(named: "ss_badge1")
        contactInfo.text = "Contact: "+activity.contact
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(let msg:String){
        let alert = UIAlertController(title: "Hurray!!", message: msg , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertEvent) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
