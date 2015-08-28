//
//  PlayersViewController.swift
//  Venbot
//
//  Created by Rob Wyant on 8/13/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//
import UIKit

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var conferenceLabel: UILabel!
    
        var data = [["name" : "Leonard Fournette", "team" : "LSU" , "venmo_id" : "Venbot3", "venmo_url" : "https://venmo.com/VenbotApp", "access_token" : "e69bf6131c0a5511f4bf20f13dba1db510294179756d037c8b4ed51aa49439cd"],["name" : "Deshaun Watson", "team" : "Clemson" , "venmo_id" : "Venbot 1", "venmo_url" : "https://venmo.com/VenbotApp", "access_token" : "e69bf6131c0a5511f4bf20f13dba1db510294179756d037c8b4ed51aa49439cd"],["name" : "Jeremy Johnson", "team" : "Auburn" , "venmo_id" : "Venbot2", "venmo_url" : "https://venmo.com/VenbotApp", "access_token" : "e69bf6131c0a5511f4bf20f13dba1db510294179756d037c8b4ed51aa49439cd"],["name" : "Cameron Robinson", "team" : "Alabama" , "venmo_id" : "Venbot5", "venmo_url" : "https://venmo.com/VenbotApp", "access_token" : "e69bf6131c0a5511f4bf20f13dba1db510294179756d037c8b4ed51aa49439cd"]]
    
    var schoolFromRequest: String?
    
    var request = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        configureNavigationBar()
        
        initiateOverlay(self.view)

        schoolFromRequest = request["school"]
        
    }
    override func viewDidAppear(animated: Bool) {
        configureNavigationBar()
    }

    func configureNavigationBar() {
        self.navigationItem.title = request["school"]
        var dominantColorHex = NSUserDefaults.standardUserDefaults().objectForKey("dominant_color_player") as? String
        var accentColorHex = NSUserDefaults.standardUserDefaults().objectForKey("accent_color_player") as? String
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: dominantColorHex!)
        var font = UIFont(name: "SFSportsNight", size: 24)
        
        var fontDict = [NSFontAttributeName : font!, NSForegroundColorAttributeName: UIColor(rgba: accentColorHex!)]
        self.navigationController?.navigationBar.titleTextAttributes = fontDict
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayersTableViewCell", forIndexPath: indexPath) as! PlayersTableViewCell
        var dominantColor = request["dominant_color"]
        var dominantColorForHex = "#\(dominantColor!)"
        
        var accentColor = request["accent_color"]
        var accentColorForHex = "#\(accentColor!)"
        
        cell.labelOutlet.text = data[indexPath.row]["name"]
        cell.labelOutlet.textColor = UIColor(rgba: accentColorForHex)
        cell.viewOutlet.backgroundColor = UIColor(rgba: dominantColorForHex)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if data[0]["name"] != "Team Probation" {
            if let request = data[indexPath.row] as? [String : String] {
                self.performSegueWithIdentifier("individualVC", sender: request)
            }
        } else {
            println("Team is on probation")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let request = sender as? [String : String] {
            var destinationViewController = segue.destinationViewController as! IndividualPlayerViewController
            destinationViewController.request = request
        }
    }
    
    func initiateOverlay(uiView: UIView) {
        var swiftOverlay: UIButton = UIButton()
        swiftOverlay.setImage(UIImage(named: "navBarImage"), forState: UIControlState.Normal)
        swiftOverlay.frame = CGRectMake(uiView.frame.minX + 8, uiView.frame.minY + 8, 41.0, 27.0);
        swiftOverlay.addTarget(self, action: "swiftBird", forControlEvents: UIControlEvents.TouchUpInside)
        swiftOverlay.tintColor = UIColor.greenColor()
        
        uiView.addSubview(swiftOverlay)
    }
    
    func swiftBird() {
        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
        var doorTwoStory = backstoryDict!["doorTwoStory"] as! String
        var backstoryURL = backstoryDict!["doorTwoURL"] as! String
        var doorTwoTitle = backstoryDict!["doorTwoTitle"] as! String
        var discussionURL = backstoryDict!["doorTwoDiscussionURL"] as! String
        
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
            self.displayAlert(title: doorTwoTitle, message: doorTwoStory, buttonText: "Thanks")
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
                    println("Detail: \(self.schoolFromRequest!)")
                    
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
