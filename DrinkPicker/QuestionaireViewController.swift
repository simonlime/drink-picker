//
//  QuestionaireViewController.swift
//  DrinkPicker
//
//  Created by Simon Li on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class QuestionaireViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var weightText : UITextField!

    @IBOutlet weak var nameText: TextField!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var phoneText: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        weightText.delegate = self
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "isMale")
        let isMale = defaults.boolForKey("isMale")
        if (isMale) {
            maleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        }
        else {
            femaleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        }

        
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextView(snder: AnyObject) {
        // Save the user settings
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger((weightText.text as NSString).integerValue, forKey: "weight")
        defaults.setValue(nameText.text, forKey: "name")
        defaults.setValue(phoneText.text, forKey: "phone")
        
        let qrController = self.storyboard!.instantiateViewControllerWithIdentifier("QRCodeController") as! QRViewController
        self.navigationController!.pushViewController(qrController, animated: true)
    }
    
    @IBAction func maleSelect(sender: AnyObject) {
        maleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        femaleButton.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1);
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "isMale")
    }
    @IBAction func femaleSelect(sender: AnyObject) {
        femaleButton.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 80/255, alpha: 1);
        maleButton.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1);
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "isMale")
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
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
