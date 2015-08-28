//
//  SchoolViewController.swift
//  Venbot
//
//  Created by Rob Wyant on 8/13/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//

import UIKit

class SchoolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var conferenceLabel: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var conferenceFromRequest: String?
    
    var secDict: [[String: String]] = [["school" : "Florida", "school_name" : "University of Florida" , "city" : "Gainesville, Florida", "mascot" : "Gators", "conference" : "SEC" , "dominant_color" : "FF4A00", "accent_color" : "0021A5"],["school" : "Alabama", "school_name" : "University of Alabama" , "city" : "Tuscaloosa, Alabama", "mascot" : "Crimson Tide", "conference" : "SEC" , "dominant_color" : "990000", "accent_color" : "FFFFFF"],["school" : "Arkansas", "school_name" : "University of Arkansas" , "city" : "Fayetteville, Arkansas", "mascot" : "Razorbacks", "conference" : "SEC" , "dominant_color" : "9D2235", "accent_color" : "FFFFFF"],["school" : "Auburn", "school_name" : "Auburn University" , "city" : "Auburn, Alabama", "mascot" : "Tigers", "conference" : "SEC" , "dominant_color" : "DD550C", "accent_color" : "03244D"]]
    var pac12Dict: [[String: String]] = [["school" : "Colorado", "school_name" : "University of Colorado Boulder" , "city" : "Boulder, Colorado", "mascot" : "Buffaloes", "conference" : "Pac-12" , "dominant_color" : "A2A4A3", "accent_color" : "CFB87C" ],["school" : "Arizona", "school_name" : "University of Arizona" , "city" : "Tucson, Arizona", "mascot" : "Wildcats", "conference" : "Pac-12" , "dominant_color" : "CC0033", "accent_color" : "003366" ],["school" : "California", "school_name" : "University of California, Berkeley" , "city" : "Berkeley, California", "mascot" : "Golden Bears", "conference" : "Pac-12" , "dominant_color" : "10066", "accent_color" : "FFCC33" ],["school" : "Arizona State", "school_name" : "Arizona State University" , "city" : "Tempe, Arizona", "mascot" : "Sun Devils", "conference" : "Pac-12" , "dominant_color" : "990033", "accent_color" : "FFB310" ]]
    var big12Dict: [[String: String]] = [["school" : "West Virginia", "school_name" : "West Virginia University" , "city" : "Morgantown, West Virginia", "mascot" : "Mountaineers", "conference" : "Big 12" , "dominant_color" : "EAAA00", "accent_color" : "002855" ],["school" : "Baylor", "school_name" : "Baylor University" , "city" : "Waco, Texas", "mascot" : "Bears", "conference" : "Big 12" , "dominant_color" : "003015", "accent_color" : "fecb00" ],["school" : "Kansas State", "school_name" : "Kansas State University" , "city" : "Manhattan, Kansas", "mascot" : "Wildcats", "conference" : "Big 12" , "dominant_color" : "512888", "accent_color" : "FFFFFF" ]]
    var accDict: [[String: String]] = [["school" : "Miami", "school_name" : "University of Miami" , "city" : "Coral Gables, FL", "mascot" : "Hurricanes", "conference" : "ACC" , "dominant_color" : "005030", "accent_color" : "F47321" ],["school" : "Boston College", "school_name" : "Boston College" , "city" : "Chestnut Hill, MA", "mascot" : "Eagles", "conference" : "ACC" , "dominant_color" : "910039", "accent_color" : "b38f59" ],["school" : "Clemson", "school_name" : "Clemson University" , "city" : "Clemson, SC", "mascot" : "Tigers", "conference" : "ACC" , "dominant_color" : "F66733", "accent_color" : "522D80" ]]
    
    var data: [String: [[String: String]]]?
    
    var request = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureNavigationBar()
        
        initiateOverlay(self.view)
        
        conferenceFromRequest = request["name"]
        
        self.data = ["SEC" : self.secDict, "Pac-12" : self.pac12Dict, "Big 12" : self.big12Dict, "ACC" : self.accDict]
    }
    
    override func viewDidAppear(animated: Bool) {
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = request["name"]
        
        var colorForLabels = request["dominant_color"]
        var dominantColorForHex = "#\(colorForLabels)"
        var accent = request["accent_color"]
        var accentColorForHex = "#\(accent!)"
        
        var dominantColorHex = NSUserDefaults.standardUserDefaults().objectForKey("dominant_color_conference") as? String
        var accentColorHex = NSUserDefaults.standardUserDefaults().objectForKey("accent_color_conference") as? String
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: dominantColorHex!)
        
        var font = UIFont(name: "SFSportsNight", size: 30)
        var fontDict = [NSFontAttributeName : font!, NSForegroundColorAttributeName: UIColor(rgba: accentColorHex!)]
        self.navigationController?.navigationBar.titleTextAttributes = fontDict
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if data != nil {
            numberOfRows = data![conferenceFromRequest!]!.count
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SchoolTableViewCell", forIndexPath: indexPath) as! SchoolTableViewCell

        var dominantColor = data![conferenceFromRequest!]![indexPath.row]["dominant_color"]
        var dominantColorForHex = "#\(dominantColor!)"
        
        var accentColor = data![conferenceFromRequest!]![indexPath.row]["accent_color"]
        var accentColorForHex = "#\(accentColor!)"
        
        cell.labelOutlet.text = data![conferenceFromRequest!]![indexPath.row]["school"]
        cell.labelOutlet.textColor = UIColor(rgba: accentColorForHex)
        cell.viewOutlet.backgroundColor = UIColor(rgba: dominantColorForHex)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let request = data![conferenceFromRequest!]![indexPath.row] as? [String : String] {
            self.performSegueWithIdentifier("playersVC", sender: request)
            
            var colorForLabels = request["dominant_color"]
            var dominantColorForHex = "#\(colorForLabels!)"
            var accent = request["accent_color"]
            var accentColorForHex = "#\(accent!)"
            
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(accentColorForHex, forKey: "accent_color_player")
            defaults.setObject(dominantColorForHex, forKey: "dominant_color_player")
            defaults.synchronize()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let request = sender as? [String : String] {
            var destinationViewController = segue.destinationViewController as! PlayersViewController
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
                    println("Detail: \(self.conferenceFromRequest!)")
                    
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
