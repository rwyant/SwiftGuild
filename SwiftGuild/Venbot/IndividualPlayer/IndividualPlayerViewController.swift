//
//  IndividualPlayerViewController.swift
//  Venbot
//
//  Created by Rob Wyant on 8/13/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//

import UIKit

class IndividualPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var balanceOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var request = [String: String]()
    var accessToken = String()
    var nwkData: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initiateOverlay(self.view)
        
        accessToken = request["access_token"]!
        
        configureNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        retrieveData()
    }
    
    func retrieveData() {
        Logic().getPlayerInfo(accessToken, completionHandler: { (tempJSON:JSON?, error:NSError?) -> () in
            if tempJSON != nil {
                var tempData = tempJSON!["data"]["balance"]
                self.balanceOutlet.text = "$\(tempData)"
            } else {
                println(error)
            }
        })
        
        Logic().getTransactionInfo(accessToken, completionHandler: { (tempJSON:JSON?, error:NSError?) -> () in
            if tempJSON != nil {
                self.nwkData = tempJSON!
                
                if self.nwkData!["data"].count != 0 {
                    self.tableViewOutlet.reloadData()
                } else {
                    self.nwkData = [ "data" : [[
                        "actor" : [
                            "display_name" : "Venbot",
                            "profile_picture_url" : "http://insideyapper.com/images/venbot.png"
                        ],
                        "amount" : "0.00",
                        "note" : "💮💮💮💮💮💮💮💮💮💮💮💮💮💮💮💮💮💮💮 Emoji Definition: 'You Did Very Well'"
                        ]]
                    ]
                    self.tableViewOutlet.reloadData()
                }
            } else {
                println(error)
            }
        })
    }
    
    func configureNavigationBar() {
        var playerName = request["name"]
        
        self.navigationItem.title = playerName!
//        UINavigationBar.appearance().titleTextAttributes = 
        
        var contentTextArr = split(playerName!) {$0 == " "}
        var nameFromContentArray = contentTextArr[0]
        buttonOutlet.setTitle("View \(nameFromContentArray) on Venmo", forState: UIControlState.Normal)
        
        var dominantColorForHex = NSUserDefaults.standardUserDefaults().objectForKey("dominant_color_player") as? String
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: dominantColorForHex!)
        
        var accentColorForHex = NSUserDefaults.standardUserDefaults().objectForKey("accent_color_player") as? String
        var font = UIFont(name: "SFSportsNight", size: 20)
        
        var fontDict = [NSFontAttributeName : font!, NSForegroundColorAttributeName: UIColor(rgba: accentColorForHex!)]
        self.navigationController?.navigationBar.titleTextAttributes = fontDict
        
        buttonOutlet.backgroundColor = UIColor(rgba: dominantColorForHex!)
        buttonOutlet.setTitleColor(UIColor(rgba: accentColorForHex!), forState: UIControlState.Normal)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if nwkData != nil {
            numberOfRows = nwkData!["data"].count
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IndividualPlayerTableViewCell", forIndexPath: indexPath) as! IndividualPlayerTableViewCell
        
        let tempData = self.nwkData!["data"][indexPath.row]

        let userName = tempData["actor"]["display_name"]
        let amount = tempData["amount"]
        let note = tempData["note"]
        cell.transactionLabel.text =  "\(userName) ($\(amount)): \(note)"
        
        let userImageURL = tempData["actor"]["profile_picture_url"]
        let url = NSURL(string: "\(userImageURL)")
        let data = NSData(contentsOfURL: url!)
        let userImage = UIImage(data: data!)
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2
        cell.userImage.layer.masksToBounds = true
        cell.userImage.layer.borderWidth = 1
        cell.userImage.image = userImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alert = UIAlertController()
        alert.title = "PLEASE READ CAREFULLY"
        alert.message = "By pressing 'okay' you acknowledge that you are leaving our app. We do not condone transferring money to this Venmo account & are free of all liability that results."
        
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Alert Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var urlString = self.request["venmo_url"]
            UIApplication.sharedApplication().openURL(NSURL(string:urlString!)!)
        }
        
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
                
    }
    
    @IBAction func buttonAction(sender: AnyObject) {

        
        let alert = UIAlertController()
        alert.title = "PLEASE READ CAREFULLY"
        alert.message = "By pressing 'okay' you acknowledge that you are leaving our app. We do not condone transferring money to this Venmo account & are free of all liability that results."

        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Alert Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            var urlString = self.request["venmo_url"]
            UIApplication.sharedApplication().openURL(NSURL(string:urlString!)!)
        }
        
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        
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
                    var detailString = self.request["name"]
                    println("Detail: \(detailString)")
                    
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
