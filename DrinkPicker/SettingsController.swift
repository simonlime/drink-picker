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
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    @IBOutlet weak var phoneText: TextField!
    @IBOutlet weak var nameText: TextField!
    @IBAction func dismiss(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger((weightText.text as NSString).integerValue, forKey: "weight")
        defaults.setInteger((phoneText.text as NSString).integerValue, forKey: "phone")
        defaults.setValue(nameText.text, forKey: "name")
        self.dismissViewControllerAnimated(true, completion: {})
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationController?.navigationBarHidden = true
        
        let defaults = NSUserDefaults.standardUserDefaults()
        weightText.text = String(format:"%d", defaults.integerForKey("weight"))
        nameText.text = defaults.valueForKey("name") as! String
        phoneText.text = defaults.valueForKey("phone") as! String
        let isMale = defaults.boolForKey("isMale")
        if (isMale) {
            maleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        }
        else {
            femaleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        }
//        ftText.text = String(format:"%f", defaults.integerForKey("ft"))
//        inText.text = String(format:"%f", defaults.integerForKey("in"))
        // Do any additional setup after loading the view.
    }

    @IBAction func selectMale(sender: AnyObject) {
        maleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        femaleButton.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1);
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "isMale")
        
    }
    @IBAction func selectFemale(sender: AnyObject) {
        femaleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        maleButton.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1);
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "isMale")
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
