//
//  QRViewController.swift
//  DrinkPicker
//
//  Created by Simon Li on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let dateFormatter = NSDateFormatter()
    
    @IBOutlet weak var code : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delay Function taken from interwebs that starts calculation after x seconds
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // Calculate BAC function
    func calcBAC() -> Double {
        var n = defaults.doubleForKey("currentDrinks")
        var W = defaults.doubleForKey("weight")
        var r = defaults.doubleForKey("genderConst")
        var BAC = n * 0.6 * 5.14 / (W * r)
        defaults.setDouble(BAC, forKey: "currentBAC")
        return BAC
    }
    
    // Subtracts drinks that disappear at (W * r) / (0.6 * 5.14 * 0.015) rate per hour
    func dissipateDrinks() {
        var n = defaults.doubleForKey("currentDrinks")
        var W = defaults.doubleForKey("weight")
        var r = defaults.doubleForKey("genderConst")
        var lastDateString = defaults.valueForKey("lastCalcDate") as! String
        var lastDate = dateFormatter.dateFromString(lastDateString)
        var secondsElapsed = NSDate().timeIntervalSinceDate(lastDate!)
        defaults.setDouble(n - ((W*r*secondsElapsed)/(0.6*5.14*0.015*3600)), forKey: "currentDrinks")
    }
    
    @IBAction func createQRTapped(sender : AnyObject) {
        var uuid = NSUUID().UUIDString
        
        code.image = {
            var qrCode = QRCode(uuid)!
            qrCode.size = self.code.bounds.size
            return qrCode.image
        }()
        
        // Initializations
        defaults.setDouble(0.0, forKey: "currentDrinks")
        defaults.setDouble(0.0, forKey: "currentBAC")
        defaults.setValue("\(NSDate())", forKey: "lastCalcDate")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss zzz"
        
        // Listener to Firebase
        var userRef = Firebase(url:"https://blazing-inferno-583.firebaseio.com/users/"+uuid)
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            var time = snapshot.value["Time"] as? String
            var drink = snapshot.value["Drink"] as? String
            
            // Update BAC and notify if "limits" reached
            self.defaults.setDouble( self.defaults.doubleForKey("currentDrinks") + 1.0, forKey: "currentDrinks")
            self.dissipateDrinks()
            self.defaults.setValue("\(NSDate())", forKey: "lastCalcDate")
            
            var BAC = self.calcBAC()
            if (BAC > 0.06) {
                // Twilio Code
                var swiftRequest = SwiftRequest()
                var account_sid = "ACb130d0fe5a782ab315ef7bf3cf6c359b"
                var auth_token = "85b546785dd5c7009f1c7e09a059d025"
                var name = self.defaults.valueForKey("name") as! String
                var friend_phone = self.defaults.valueForKey("friend_phone") as! String
                var data = [
                    "To" : friend_phone,
                    "From" : "+17027897673",
                    "Body" : "Hi responsible citizen! Your friend " + name + " has had too much to drink. Please pick him/her up at <location>. Sincerely, Sipper"
                ]
        
                swiftRequest.post("https://api.twilio.com/2010-04-01/Accounts/"+account_sid+"/Messages",
                    auth: ["username" : account_sid, "password" : auth_token],
                    data: data,
                    callback: {err, response, body in
                        if err == nil {
                            println("Success: \(response)")
                        } else {
                            println("Error: \(err)")
                        }
                });
                
                // Notification Code
                var notification = UILocalNotification()
                notification.alertBody = "Sorry friend, you're over your limit :<" // text that will be displayed in the notification
                notification.alertAction = "Acknowledge" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
                notification.fireDate = NSDate().dateByAddingTimeInterval(60) // todo item due date (when notification will be fired)
                notification.soundName = UILocalNotificationDefaultSoundName // play default sound
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            } else if (BAC >= 0.05) {
                
                // Notification Code
                var notification = UILocalNotification()
                notification.alertBody = "Sipper recommends you stay at this buzz for max enjoyment" // text that will be displayed in the notification
                notification.alertAction = "Thumbs Up!" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
                notification.fireDate = NSDate().dateByAddingTimeInterval(60) // todo item due date (when notification will be fired)
                notification.soundName = UILocalNotificationDefaultSoundName // play default sound
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            }
            
        })
        

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
