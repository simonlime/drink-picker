//
//  SettingsController.swift
//  DrinkPicker
//
//  Created by Simon Li on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var ftText: UITextField!
    @IBOutlet weak var inText: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        weightText.text = String(format:"%f", defaults.integerForKey("weight"))
        ftText.text = String(format:"%f", defaults.integerForKey("ft"))
        inText.text = String(format:"%f", defaults.integerForKey("in"))
        // Do any additional setup after loading the view.
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
