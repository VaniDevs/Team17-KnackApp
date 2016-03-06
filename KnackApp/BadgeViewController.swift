//
//  BadgeViewController.swift
//  KnackApp
//
//  Created by Sebastian Valdivia on 2016-03-06.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

class BadgeViewController: UIViewController {

    @IBOutlet weak var badgeDescription: UILabel!
    @IBOutlet weak var badgeImg: UIImageView!
//    @IBOutlet weak var badgeName: UILabel!
    
    var badgeInfo = badge()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        badgeImg.image = UIImage(named: badgeInfo.img)
//        badgeName.text = badgeInfo.name
        badgeDescription.text = badgeInfo.description
        
    }

    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
