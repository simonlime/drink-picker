//
//  MenuController.swift
//  DrinkPicker
//
//  Created by Raghav Subramaniam on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String) {
        titleLabel.text = title
    }
}

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var drinks: [String] = ["12oz Beer", "5oz Wine"]
    var nums: [String] = ["1", "1"]
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        
        var title = drinks[indexPath.row]
        cell.loadItem(title: title)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // go to scanner
        let scanner = self.storyboard?.instantiateViewControllerWithIdentifier("scanner") as! ScannerController
        scanner.drinkNameFromMenu = drinks[indexPath.row]
        scanner.numDrinksFromMenu = nums[indexPath.row]
        self.navigationController?.pushViewController(scanner, animated: true)
    }
    
    // remove drink
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            drinks.removeAtIndex(indexPath.row)
            nums.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // add drink
    
    @IBAction func addDrinkDialogue(sender: AnyObject) {
        
        var nameTextField: UITextField?
        var numTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Add a drink.", message: "Provide a name and an effective number of drinks.", preferredStyle: .Alert)
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.placeholder = "Drink Name"
            nameTextField = textField
        }
        
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.placeholder = "Effective Number of Drinks"
            textField.keyboardType = .DecimalPad
            numTextField = textField
        }
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .Default) { action -> Void in
            self.drinks.append(nameTextField!.text)
            self.nums.append(numTextField!.text)
            self.tableView.reloadData()
        }
        actionSheetController.addAction(nextAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}