//
//  Overlay.swift
//  SwiftGuild
//
//  Created by Rob Wyant on 8/19/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import Foundation
import UIKit

class Overlay {
//    func initiateOverlay(uiView: UIView) {
//        var swiftOverlay: UIButton = UIButton()
//        swiftOverlay.setImage(UIImage(named: "navBarImage"), forState: UIControlState.Normal)
//        swiftOverlay.frame = CGRectMake(uiView.frame.minX + 8, uiView.frame.minY + 8, 41.0, 27.0);
//        swiftOverlay.addTarget(self, action: "swiftBird", forControlEvents: UIControlEvents.TouchUpInside)
//        swiftOverlay.tintColor = UIColor.greenColor()
//        
//        uiView.addSubview(swiftOverlay)
//    }
//    
//    func swiftBird() {
//        let alert = UIAlertController()
//        alert.title = "What would you like to do?"
//        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
//            UIAlertAction in
//            println("Share Button cancelled.")
//        }
//        var firstButtonAction = UIAlertAction(title: "Go Home", style: UIAlertActionStyle.Default) {
//            UIAlertAction in
//            var mainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! ViewController
//            self.presentViewController(mainVC, animated: true, completion: nil)
//        }
//        var secondButtonAction = UIAlertAction(title: "Leave Feedback", style: UIAlertActionStyle.Default) {
//            UIAlertAction in
//            self.enterFeedback()
//        }
//        
//        alert.addAction(secondButtonAction)
//        alert.addAction(firstButtonAction)
//        alert.addAction(cancelButtonAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func enterFeedback() {
//        var textFieldText = ""
//        var loadWebsiteAction = UIAlertAction()
//        var alert = UIAlertController(title: "Leave Feedback", message: "A GA MobDev alumn spent a lot of time on this project. Leave them some feedback! \n\nWhatever you say will be sent directly to the developer and will be \nTAGGED TO THIS SCREEN. \n\nThanks for your support.", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
//            textField.placeholder = "Comment on this screen..."
//            textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
//            textField.autocorrectionType = UITextAutocorrectionType.Yes
//            loadWebsiteAction = UIAlertAction(title: "Send", style: UIAlertActionStyle.Default) {
//                UIAlertAction in
//                println(textField.text)
//                println(self)
//                self.displayAlert(title: "Feedback Sent", message: "Thank you for your feedback! \n\nWe will share your comments with the developer of this project.", buttonText: "No Problem")
//            }
//        })
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        alert.addAction(loadWebsiteAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func displayAlert(#title: String, message: String, buttonText: String) {
//        let alert = UIAlertView()
//        alert.title = title
//        alert.message = message
//        // We can add other buttons
//        alert.addButtonWithTitle(buttonText)
//        // We call the show() method once we have all of our alert properties set
//        alert.show()
//    }
}