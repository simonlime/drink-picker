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
    
    var items: [String] = ["Beer", "Wine", "Liquor"]
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        
        var title = items[indexPath.row]
        cell.loadItem(title: title)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //println("You selected cell #\(items[indexPath.row]).")
        
        // go to scanner
        let scanner = self.storyboard?.instantiateViewControllerWithIdentifier("scanner") as! ScannerController
        scanner.drinkString = items[indexPath.row]
        self.navigationController?.pushViewController(scanner, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
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
