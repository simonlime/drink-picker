//
//  ScannerController.swift
//  DrinkPicker
//
//  Created by Raghav Subramaniam on 4/18/15.
//  Copyright (c) 2015 Brandon Eusebio. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let captureSession:AVCaptureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    var scannedString: String = ""
    var drinkNameFromMenu: String = ""
    var numDrinksFromMenu: String = ""
    
    @IBOutlet weak var messageLabel:UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func returnToMenu(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Set the input device on the capture session.
        captureSession.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back.
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label to the top view.
        view.bringSubviewToFront(messageLabel)
        view.bringSubviewToFront(backButton)
        
        // Initialize QR Code Frame to highlight the QR code.
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            messageLabel.text = "No QR code is detected."
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds.
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                scannedString = metadataObj.stringValue
                messageLabel.text = scannedString
                self.captureSession.stopRunning()
                
                var uuid = scannedString
                var date = NSDate()
                var drinkName = drinkNameFromMenu
                var numDrinks = numDrinksFromMenu
                
                // Update Firebase with new user and drink
                var rootRef = Firebase(url:"https://blazing-inferno-583.firebaseio.com/")
                var userRef = rootRef.childByAppendingPath("users/" + uuid)
                userRef.childByAutoId().setValue(["Time": "\(date)", "DrinkName": drinkName, "NumDrinks": numDrinks])
            }
        }
        
        // TODO: Firebase stuff
        
        // Exit the view
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}