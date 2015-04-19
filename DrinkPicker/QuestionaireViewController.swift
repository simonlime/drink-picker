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
    @IBOutlet var ftText : UITextField!
    @IBOutlet var inText : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        weightText.delegate = self
        ftText.delegate = self
        inText.delegate = self
        
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
        defaults.setDouble((weightText.text as NSString).doubleValue, forKey: "weight")
        defaults.setDouble((ftText.text as NSString).doubleValue, forKey: "ft")
        defaults.setDouble((inText.text as NSString).doubleValue, forKey: "in")
        
        let qrController = self.storyboard!.instantiateViewControllerWithIdentifier("QRCodeController") as! QRViewController
        self.navigationController!.pushViewController(qrController, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField === weightText) {
            ftText.becomeFirstResponder()
            weightText.resignFirstResponder()
        }
        else if (textField === ftText) {
            inText.becomeFirstResponder()
            ftText.resignFirstResponder()
        }
        else if (textField === inText) {
            inText.resignFirstResponder()
        }
        
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
