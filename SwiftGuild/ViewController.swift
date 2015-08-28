//
//  ViewController.swift
//  SwiftGuild
//
//  Created by Rob Wyant on 7/27/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var dialogView: DesignableView!
    @IBOutlet weak var overlayButton: UIButton!
    @IBOutlet weak var bkgOutlet: UIImageView!
    @IBOutlet weak var doorOne: UIButton!
    @IBOutlet weak var doorTwo: UIButton!
    @IBOutlet weak var doorThree: UIButton!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonVerticalConstraintOne: NSLayoutConstraint!
    @IBOutlet weak var buttonVerticalConstraintTwo: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var screenHeight: CGFloat?
    var screenWidth: CGFloat?
    var button: HamburgerButton! = nil
    
    var shareDict = [
        "firstTitle" : "Follow GA on LinkedIn",
        "firstMessage" : "https://www.linkedin.com/company/2408664",
        "secondTitle" : "Follow GA on Instagram",
        "secondMessage" : "https://instagram.com/generalassembly/?hl=en",
        "thirdTitle" : "Follow GA on Twitter",
        "thirdMessage" : "https://twitter.com/ga",
        "fourthTitle" : "Follow GA on Facebook",
        "fourthMessage" : "https://www.facebook.com/gnrlassembly"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadBackstoryData()
        
        screenHeight = UIScreen.mainScreen().bounds.height
        screenWidth = UIScreen.mainScreen().bounds.width
        
        if screenWidth! > 413.0 {
            bkgOutlet.contentMode = UIViewContentMode.ScaleAspectFill
        }
        
        self.button = HamburgerButton(frame: CGRectMake(screenWidth!*0.0625, screenHeight!*0.065140845, screenWidth!*0.16875, screenHeight!*0.095070423))
        self.button.addTarget(self, action: "menuButtonDidTouch:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(button)
        
        layoutButtons()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func layoutButtons() {
        buttonHeightConstraint.constant = (screenHeight! * 0.11443662)
        buttonBottomConstraint.constant = (screenHeight! * 0.13028169)
        buttonVerticalConstraintOne.constant = (screenHeight! * 0.03304323)
        buttonVerticalConstraintTwo.constant = (screenHeight! * 0.03304323)
        
        self.doorOne.addTarget(self, action: "doorOneSelected", forControlEvents: UIControlEvents.TouchDown)
        self.doorTwo.addTarget(self, action: "doorTwoSelected", forControlEvents: UIControlEvents.TouchDown)
        self.doorThree.addTarget(self, action: "doorThreeSelected", forControlEvents: UIControlEvents.TouchDown)
        self.doorOne.addTarget(self, action: "doorDeselected", forControlEvents: UIControlEvents.TouchUpOutside)
        self.doorTwo.addTarget(self, action: "doorDeselected", forControlEvents: UIControlEvents.TouchUpOutside)
        self.doorThree.addTarget(self, action: "doorDeselected", forControlEvents: UIControlEvents.TouchUpOutside)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func downloadBackstoryData() {
        var doorOneTitle = "Cereal: The Game"
        var doorOneStory = "September Edition: \n\nWelcome to the SwiftGuild App!\n\nOur community is made up GA MobDev alumni, and we have hand-picked some fantastic projects for you.\n\nPlease remember that while these projects are fully-functional, they're raw and need some help with UI, UX, Tech, etc. Feel free to clone our GitRepo at http://github.com/swiftguild; we welcome your input."
        var doorOneURL = "https://github.com/rwyant/SwiftGuild/tree/master/SwiftGuild/Cereal"
        var doorTwoTitle = "Venbot"
        var doorTwoStory = "September Edition: \n\nWelcome to the SwiftGuild App!\n\nOur community is made up GA MobDev alumni, and we have hand-picked some fantastic projects for you.\n\nPlease remember that while these projects are fully-functional, they're raw and need some help with UI, UX, Tech, etc. Feel free to clone our GitRepo at http://github.com/swiftguild; we welcome your input."
        var doorTwoURL = "https://github.com/rwyant/SwiftGuild/tree/master/SwiftGuild/Venbot"
        var doorThreeTitle = "Student Showcase"
        var doorThreeStory = "September Edition: \n\nWelcome to the SwiftGuild App!\n\nOur community is made up GA MobDev alumni, and we have hand-picked some fantastic projects for you.\n\nPlease remember that while these projects are fully-functional, they're raw and need some help with UI, UX, Tech, etc. Feel free to clone our GitRepo at http://github.com/swiftguild; we welcome your input."
        var doorThreeURL = "https://github.com/rwyant/SwiftGuild"
        var doorOneDiscussionURL = "https://www.reddit.com/r/swiftguild/"
        var doorTwoDiscussionURL = "https://www.reddit.com/r/swiftguild/"
        var doorThreeDiscussionURL = "https://www.reddit.com/r/swiftguild/"
        var version = "September 2015 Edition: \n\nWelcome to the SwiftGuild App!\n\nOur community is made up GA MobDev alumni, and we have hand-picked some fantastic projects for you.\n\nPlease remember that while these projects are fully-functional, they're raw and need some help with UI, UX, Tech, etc. Feel free to clone our GitRepo at http://github.com/swiftguild; we welcome your input."
        var versionTitle = "Swift Guild App v1.0"
        
        var dataObject = ["doorOneStory" : doorOneStory, "doorOneURL" : doorOneURL, "doorTwoStory" : doorTwoStory, "doorTwoURL" : doorTwoURL, "doorThreeStory" : doorThreeStory, "doorThreeURL" : doorThreeURL, "doorTwoTitle" : doorTwoTitle, "doorOneTitle" : doorOneTitle, "doorThreeTitle" : doorThreeTitle, "doorOneDiscussionURL" : doorOneDiscussionURL, "doorTwoDiscussionURL" : doorTwoDiscussionURL, "doorThreeDiscussionURL" : doorThreeDiscussionURL, "version" : version, "versionTitle" : versionTitle]
        
        NSUserDefaults.standardUserDefaults().setObject(dataObject, forKey: "backstoryDictionary")
    }
    
    func doorDeselected() {
        bkgOutlet.image = UIImage(named: "bkg")
    }
    
    func doorOneSelected() {
        bkgOutlet.image = UIImage(named: "selectOne")
    }
    func doorTwoSelected() {
        bkgOutlet.image = UIImage(named: "selectTwo")
    }
    func doorThreeSelected() {
        bkgOutlet.image = UIImage(named: "selectThree")
    }
    
    @IBAction func doorOneAction(sender: UIButton) {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorOneStory = backstoryDict!["doorOneStory"] as! String
        var backstoryURL = backstoryDict!["doorOneURL"] as! String
        var doorOneTitle = backstoryDict!["doorOneTitle"] as! String
        var discussionURL = backstoryDict!["doorOneDiscussionURL"] as! String
        
        let alert = UIAlertController()
        alert.title = "You are about to enter into a \nMURDER MYSTERY ADVENTURE\n\nPlay around, have fun, and remember to click the Swift bird to come back home."
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button Cancelled")
        }
        var firstButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = discussionURL
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var secondButtonAction = UIAlertAction(title: "View The Code", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = backstoryURL
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var thirdButtonAction = UIAlertAction(title: "Enter The App", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.displayAlert(title: doorOneTitle, message: doorOneStory, buttonText: "Thanks")
            var cerealVC = self.storyboard?.instantiateViewControllerWithIdentifier("cerealVC") as! UINavigationController
            self.presentViewController(cerealVC, animated: true, completion: nil)
        }
        alert.addAction(thirdButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(secondButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
        bkgOutlet.image = UIImage(named: "bkg")
    }
    
    @IBAction func doorTwoAction(sender: UIButton) {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorTwoStory = backstoryDict!["doorTwoStory"] as! String
        var backstoryURL = backstoryDict!["doorTwoURL"] as! String
        var doorTwoTitle = backstoryDict!["doorTwoTitle"] as! String
        var discussionURL = backstoryDict!["doorTwoDiscussionURL"] as! String
        
        let alert = UIAlertController()
        alert.title = "You are about to enter a \nVENBOT APP\n\nPlay around, have fun, and remember to click the Swift bird to come back home."
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = discussionURL
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var secondButtonAction = UIAlertAction(title: "View The Code", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = backstoryURL
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var thirdButtonAction = UIAlertAction(title: "Enter The App", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.displayAlert(title: doorTwoTitle, message: doorTwoStory, buttonText: "Thanks")
            var venbotVC = self.storyboard?.instantiateViewControllerWithIdentifier("venbotVC") as! UINavigationController
            self.presentViewController(venbotVC, animated: true, completion: nil)
        }
        alert.addAction(thirdButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(secondButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
        bkgOutlet.image = UIImage(named: "bkg")
    }

    @IBAction func doorThreeAction(sender: UIButton) {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorThreeStory = backstoryDict!["doorThreeStory"] as! String
        var backstoryURL = backstoryDict!["doorThreeURL"] as! String
        var doorThreeTitle = backstoryDict!["doorThreeTitle"] as! String
        var discussionURL = backstoryDict!["doorThreeDiscussionURL"] as! String
        
        let alert = UIAlertController()
        alert.title = "You are about to enter a \nSTUDENT SHOWCASE\n\nPlay around, have fun, and remember to click the Swift bird to come back home."
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = discussionURL
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var secondButtonAction = UIAlertAction(title: "Enter The Project", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.displayAlert(title: doorThreeTitle, message: doorThreeStory, buttonText: "Thanks")
            var requestURL: String?
            requestURL = "http://codedre.com/mysite/"
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        alert.addAction(secondButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
        bkgOutlet.image = UIImage(named: "bkg")
    }
    
    func menuButtonDidTouch(sender: AnyObject) {
        buttonShowsMenu()
        dialogView.hidden = false
        dialogView.userInteractionEnabled = true
        overlayButton.hidden = false
        overlayButton.userInteractionEnabled = true
        self.button.userInteractionEnabled = false
        dialogView.animation = "slideDown"
        dialogView.animate()
    }
    
    func buttonShowsMenu() {
        self.button.showsMenu = !self.button.showsMenu
    }
    
    @IBAction func dismissMenuView(sender: AnyObject) {
        buttonShowsMenu()
        self.overlayButton.hidden = true
        self.overlayButton.userInteractionEnabled = false
        dialogView.animation = "fall"
        dialogView.animate()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.button.userInteractionEnabled = true
            self.dialogView.hidden = true
            self.dialogView.userInteractionEnabled = false
        }        
    }

    
    @IBAction func designableButtonOne(sender: AnyObject) {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var versionString = backstoryDict!["version"] as! String
        var versionTitle = backstoryDict!["versionTitle"] as! String
        displayAlert(title: versionTitle, message: versionString, buttonText: "Let Me Play!")
    }
    
    @IBAction func designableButtonTwo(sender: AnyObject) {
        var requestURL: String?
        requestURL = "https://generalassemb.ly"
        if let request: AnyObject = requestURL {
            self.performSegueWithIdentifier("showWebView", sender: request)
        }
    }
    
    @IBAction func designableButtonThree(sender: AnyObject) {
        shareAlert()
    }

    @IBAction func designableButtonFour(sender: AnyObject) {
        let mailComposeViewController = self.configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func shareAlert() {
        let alert = UIAlertController()
        alert.title = "What would you like to do?"
        //        alert.message = "What would you like to do?"
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: shareDict["firstTitle"]!, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = self.shareDict["firstMessage"]!
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
            
            //            UIApplication.sharedApplication().openURL(NSURL(string:shareDict["firstMessage"]!)!)
        }
        var secondButtonAction = UIAlertAction(title: shareDict["secondTitle"]!, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = self.shareDict["secondMessage"]!
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
            //            UIApplication.sharedApplication().openURL(NSURL(string:shareDict["secondMessage"]!)!)
        }
        var thirdButtonAction = UIAlertAction(title: shareDict["thirdTitle"]!, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = self.shareDict["thirdMessage"]!
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
        }
        var fourthButtonAction = UIAlertAction(title: shareDict["fourthTitle"]!, style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = self.shareDict["fourthMessage"]!
            if let request: AnyObject = requestURL {
                self.performSegueWithIdentifier("showWebView", sender: request)
            }
            //            UIApplication.sharedApplication().openURL(NSURL(string:shareDict["fourthMessage"]!)!)
        }
        alert.addAction(fourthButtonAction)
        alert.addAction(thirdButtonAction)
        alert.addAction(secondButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["swiftguild@getyapper.com"])
        mailComposerVC.setSubject("SwiftGuild App: Feedback")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func displayAlert(#title: String, message: String, buttonText: String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        // We can add other buttons
        alert.addButtonWithTitle(buttonText)
        // We call the show() method once we have all of our alert properties set
        alert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let request = sender as? String {
            var destinationViewController = segue.destinationViewController as! WebViewViewController
            destinationViewController.URL = request
        }
    }
    
    
}

