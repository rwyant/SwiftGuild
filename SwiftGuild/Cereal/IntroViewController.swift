//
//  IntroViewController.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/23/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit
import MessageUI

class IntroViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var introText: UITextView!
    
    @IBAction func sendEmailButton(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([])
        mailComposerVC.setSubject("Cereal The Game: Evidence and Questions")
        mailComposerVC.setMessageBody("Hello adventurers,\n\nYou are about to embark on a murder mystery audio journey. To solve the case, you will need to consult the evidence.\n\nhttp://surpriseindustries.com/cereal-the-game-evidence/\n\nKeep this link handy. You will refer back to it after each episode you hear.\n\nAnd now, for The Big 12 Questions... dun dun dun! Skim through these, and use them as your guide as you listen to the case. Remember, it's 1 point for each right answer.\n\n1) When did Marcus board the ship on the evening of March 1st? If he did not board the ship that evening, write N/A.\n2) Who wrote 'Marcus Hailey' on the sign-in sheet? (Marcus is a possible answer!)\n3) How did the check-in system go down?\n4) What place is referred to in the cryptic note?\n5) What's the translation of the attendance sheet note?\n6) Whose prints were found on the cereal boxes in Jason's room?\n7) What motive did the person(s) have for giving Marcus the box of Rice Krispies?\n8) Where was Marcus from 12:00 AM until 2:30 AM?\n9) What evidence, if any, backs up the crew member's 2:30 AM sighting?\n10) Who killed Marcus?\n11) What do Marcus's injuries tell us about where he was killed?\n12) Why did the killer do it?\n\nNow, head over to Episode 1 in your Cereal The Game app and let's get started!\n\nHappy sleuthing,\n\nThe Surprisologists at Surprise Industries", isHTML: false)
//        var myPDF = NSData(contentsOfFile: path)!
//        var pdfData:NSData = myPDF
        ////        var imageData = UIImagePNGRepresentation(myUIImage)
//        mailComposerVC.addAttachmentData(pdfData, mimeType: "application/pdf", fileName: "cereal")
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initiateOverlay(self.view)
//        self.introText.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.introText.setContentOffset(CGPointMake(0, 300), animated: false)
//        self.introText.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initiateOverlay(uiView: UIView) {
        var swiftOverlay: UIButton = UIButton()
        swiftOverlay.setImage(UIImage(named: "navBarImage"), forState: UIControlState.Normal)
        swiftOverlay.frame = CGRectMake(uiView.frame.minX + 8, uiView.frame.minY + 75, 41.0, 27.0);
        swiftOverlay.addTarget(self, action: "swiftBird", forControlEvents: UIControlEvents.TouchUpInside)
        swiftOverlay.tintColor = UIColor.greenColor()
        
        uiView.addSubview(swiftOverlay)
    }
    
    func swiftBird() {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorOneStory = backstoryDict!["doorOneStory"] as! String
        var backstoryURL = backstoryDict!["doorOneURL"] as! String
        var doorOneTitle = backstoryDict!["doorOneTitle"] as! String
        var discussionURL = backstoryDict!["doorOneDiscussionURL"] as! String
        
        let alert = UIAlertController()
        alert.title = "What would you like to do?"
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Go Home", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var mainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! ViewController
            self.presentViewController(mainVC, animated: true, completion: nil)
        }
        var secondButtonAction = UIAlertAction(title: "Leave Feedback", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.enterFeedback()
        }
        var thirdButtonAction = UIAlertAction(title: "Read The Backstory", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.displayAlert(title: doorOneTitle, message: doorOneStory, buttonText: "Thanks")
        }
        var fourthButtonAction = UIAlertAction(title: "View The Code", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = backstoryURL
            NSUserDefaults.standardUserDefaults().setObject(requestURL!, forKey: "urlForWebView")
            
            var webVC = self.storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebViewViewController
            self.presentViewController(webVC, animated: true, completion: nil)
        }
        var fifthButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = discussionURL
            NSUserDefaults.standardUserDefaults().setObject(requestURL!, forKey: "urlForWebView")
            
            var webVC = self.storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebViewViewController
            self.presentViewController(webVC, animated: true, completion: nil)
        }
        
        alert.addAction(secondButtonAction)
        alert.addAction(thirdButtonAction)
        alert.addAction(fifthButtonAction)
        alert.addAction(fourthButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func enterFeedback() {
        var textFieldText = ""
        var loadWebsiteAction = UIAlertAction()
        var alert = UIAlertController(title: "Leave Feedback", message: "A GA MobDev alumn spent a lot of time on this project. Leave your feedback! \n\nWhatever you say will be sent directly to the developer and will be \nTAGGED TO THIS SCREEN. \n\nThanks for your support.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Comment on this screen..."
            textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
            textField.autocorrectionType = UITextAutocorrectionType.Yes
            loadWebsiteAction = UIAlertAction(title: "Send", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                if textField.text == "" {
                    self.displayAlert(title: "Error Sending Feedback", message: "Hmm... it doesn't look like you typed anything. Please try that again!", buttonText: "My Bad")
                } else {
                    println("Normally, the app would send the following data points to Parse. However, for security purposes we have removed all connections to Parse. The data points remain the same.")
                    println("Feedback: \(textField.text)")
                    if self.title == nil {
                        println("Title: \(self)")
                    } else {
                        println("Title: \(self.title!)")
                    }
                    println("Detail: Cereal Intro & Rules")
                    
                    self.displayAlert(title: "Feedback Sent", message: "Thank you for your feedback! \n\nWe will share your comments with the developer of this project.", buttonText: "Cool")
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(loadWebsiteAction)
        self.presentViewController(alert, animated: true, completion: nil)
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

}
