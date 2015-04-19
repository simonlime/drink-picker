//
//  ViewController.swift
//  DrinkPicker
//
//  Created by Brandon Eusebio on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bargoerButton : UIButton!
    @IBOutlet var bartenderButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bargoerTapped(sender : AnyObject) {
    }
    
    @IBAction func bartenderTapped(sender : AnyObject) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }

}

