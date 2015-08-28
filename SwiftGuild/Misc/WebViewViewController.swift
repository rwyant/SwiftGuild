//
//  WebViewViewController.swift
//  Masa Israel
//
//  Created by Rob Wyant on 6/29/15.
//  Copyright (c) 2015 YAPPERapp, LLC. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var fwdBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var webViewOutlet: UIWebView!
    @IBOutlet weak var bottomNavOutlet: UIView!
    @IBOutlet weak var navigationBarOutlet: UINavigationBar!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!

    var URLWithoutWWW = String()
    var hasFinishedLoading = false

    var URL: String?
    var termRequest: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFormatting()
        
        if URL == nil {
            URL = NSUserDefaults.standardUserDefaults().objectForKey("urlForWebView") as? String
        }
        
        let newURL = URL!
        if newURL.contains("www") {
            var contentTextArr = newURL.componentsSeparatedByString("www")
            URLWithoutWWW = "\(contentTextArr[1])"
        }
        
        if URL == "http://codedre.com/mysite/" {
            self.rightBarButtonItem.addTargetForAction(self, action: "swiftBirdForDoorThree")
        } else {
            self.rightBarButtonItem.addTargetForAction(self, action: "swiftBird")
        }
        
        var urlString = NSURL(string:URL!)
        var htmlRequest = NSURLRequest(URL: urlString!)
        webViewOutlet.delegate = self
        self.webViewOutlet.loadRequest(htmlRequest)
    }
    
    func configureFormatting() {
        var colorForLabels = UIColor.blackColor()
        bottomNavOutlet.backgroundColor = colorForLabels
        navigationBarOutlet.barTintColor = colorForLabels
        
//        var logo = UIImage(named: "navBarImage")
//        var navImageView = UIImageView(image: logo)
//        navImageView.tintColor = UIColor.greenColor()
//        var navBarButtonItem = UIBarButtonItem(customView: navImageView)
//        rightBarButtonItem = navBarButtonItem
//        rightBarButtonItem.title = "TESTING"
//        rightBarButtonItem.addTargetForAction(self, action: "swiftBird")

        
        var dominantColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        var fontDict = [NSForegroundColorAttributeName: dominantColor]
        navigationBarOutlet.titleTextAttributes = fontDict
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        webViewOutlet.stopLoading()
        webViewOutlet.goBack()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.fwdBtn.enabled = true
        }
    }
    @IBAction func forwardButton(sender: AnyObject) {
        webViewOutlet.stopLoading()
        webViewOutlet.goForward()
    }
    @IBAction func stopButton(sender: AnyObject) {
        webViewOutlet.stopLoading()
        progressView.progress = 1
        webViewDidFinishLoad(webViewOutlet)
    }
    @IBAction func shareButton(sender: AnyObject) {
        shareAlert()        
    }
    @IBAction func closeVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func shareAlert() {
        let alert = UIAlertController()
        alert.title = "What would you like to do?"
        //        alert.message = "What would you like to do?"
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Copy URL To Clipboard", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            UIPasteboard.generalPasteboard().string = self.webViewOutlet.request!.URL!.absoluteString
        }
        var secondButtonAction = UIAlertAction(title: "Open URL In Safari", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.webViewOutlet.stopLoading()
            UIApplication.sharedApplication().openURL(NSURL(string:self.webViewOutlet.request!.URL!.absoluteString!)!)
        }

        alert.addAction(secondButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
        if progressView.hidden == true {
            progressView.progress = 0.0
            progressView.hidden = false

            stopBtn.enabled = true
            backBtn.enabled = true
            shareBtn.enabled = false
            fwdBtn.enabled = false
        }
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
                
                self!.stopBtn.enabled = false
                self!.shareBtn.enabled = true
                
                var currentURL = ""
                let newURL = self!.webViewOutlet.request?.URL?.absoluteString!
                if newURL!.contains("www") {
                    var contentTextArr = newURL!.componentsSeparatedByString("www")
                    currentURL = "\(contentTextArr[1])"
                }
                
                if currentURL == self!.URLWithoutWWW {
                    self!.backBtn.enabled = false
                }
            }
        }
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }
    
    func swiftBird() {
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
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func swiftBirdForDoorThree() {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorThreeStory = backstoryDict!["doorThreeStory"] as! String
        var backstoryURL = backstoryDict!["doorThreeURL"] as! String
        var doorThreeTitle = backstoryDict!["doorThreeTitle"] as! String
        var discussionURL = backstoryDict!["doorThreeDiscussionURL"] as! String
        
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
            self.displayAlert(title: doorThreeTitle, message: doorThreeStory, buttonText: "Thanks")
        }
        var fourthButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var requestURL: String?
            requestURL = discussionURL
            NSUserDefaults.standardUserDefaults().setObject(requestURL!, forKey: "urlForWebView")
            
            var webVC = self.storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebViewViewController
            self.presentViewController(webVC, animated: true, completion: nil)
        }
        alert.addAction(secondButtonAction)
        alert.addAction(thirdButtonAction)
        alert.addAction(fourthButtonAction)
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func enterFeedback() {
        var textFieldText = ""
        var loadWebsiteAction = UIAlertAction()
        var alert = UIAlertController(title: "Leave Feedback", message: "A GA MobDev alumn spent a lot of time on this project. Leave them some feedback! \n\nWhatever you say will be sent directly to the developer and will be \nTAGGED TO THIS SCREEN. \n\nThanks for your support.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Comment on this screen..."
            textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
            textField.autocorrectionType = UITextAutocorrectionType.Yes
            loadWebsiteAction = UIAlertAction(title: "Send", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                println("Normally, the app would send the following data points to Parse. However, for security purposes we have removed all connections to Parse. The data points remain the same.")
                println("Feedback: \(textField.text)")
                if self.title == nil {
                    println("Title: \(self)")
                } else {
                    println("Title: \(self.title!)")
                }
                println("Detail: \(self.URL!)")
                
                self.displayAlert(title: "Feedback Sent", message: "Thank you for your feedback! \n\nWe will share your comments with the developer of this project.", buttonText: "No Problem")
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
    }}

extension UIBarButtonItem {
    func addTargetForAction(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}
