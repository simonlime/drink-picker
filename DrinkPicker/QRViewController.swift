//
//  QRViewController.swift
//  DrinkPicker
//
//  Created by Simon Li on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    @IBOutlet weak var code : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createQRTapped(sender : AnyObject) {
        var uuid = NSUUID().UUIDString
        
        code.image = {
            var qrCode = QRCode(uuid)!
            qrCode.size = self.code.bounds.size
            return qrCode.image
        }()
        
//        // Twilio Code
//        var swiftRequest = SwiftRequest()
//        var account_sid = "ACb130d0fe5a782ab315ef7bf3cf6c359b"
//        var auth_token = "85b546785dd5c7009f1c7e09a059d025"
//        var data = [
//            "To" : "+17025457039",
//            "From" : "+17027897673",
//            "Body" : "Bro, you Gucci?"
//        ]
//        
//        swiftRequest.post("https://api.twilio.com/2010-04-01/Accounts/"+account_sid+"/Messages",
//            auth: ["username" : account_sid, "password" : auth_token],
//            data: data,
//            callback: {err, response, body in
//                if err == nil {
//                    println("Success: \(response)")
//                } else {
//                    println("Error: \(err)")
//                }
//        });
        
        // Initialize Listener to Firebase
        var userRef = Firebase(url:"https://blazing-inferno-583.firebaseio.com/users/"+uuid)
        userRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            var time = snapshot.value["Time"] as? String
            var drink = snapshot.value["Drink"] as? String
            
            // TODO: Feed into algorithm
            
            
            
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
