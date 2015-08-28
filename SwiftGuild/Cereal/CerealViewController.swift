//
//  ViewController.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/7/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit

class CerealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var paragraph: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var data:[[Chapters]] = [[
        Chapters(chapter: "Intro: The Rules", chapterNumber: "Intro", founded: "Everything you need to know to play the game (and beat the other players).", isInternational: false, read:false),
        Chapters(chapter: "Ep. 1: The Truth", chapterNumber: "1", founded: "Meet Kara Seinig, a journalist investigating the Cereal Killing case.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 2: The Facts", chapterNumber: "2", founded:  "Figure out the timeline on the last day Marcus Hailey was seen alive.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 3: The Suspects", chapterNumber: "3", founded:  "Meet the cast of characters who might have something to do with the murder.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 4: Lauralynn", chapterNumber: "4", founded:  "Meet Lauralynn, a sweet southern girl who may be hiding something.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 5: Vicky", chapterNumber: "5", founded: "Meet Vicky, Jeff’s ex, who may have wanted Marcus out of the picture.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 6: Paige", chapterNumber: "6", founded: "Meet Paige, a college professor who may have been involved with Marcus.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 7: Jason", chapterNumber: "7", founded:  "Meet Jason, a Study at Sea student who may have been Marcus’s rival.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 8: Final Discussion", chapterNumber: "8", founded:  "Finalize your answers to The Big 12 Questions and let's discuss.", isInternational: false, read:false),
        Chapters(chapter: "Ep. 9: The Reveal", chapterNumber: "9", founded:  "Time for the moment of truth: did you crack the case?", isInternational: false, read:false)
        ], [Chapters(chapter: "Surprise Industries", chapterNumber: "?",  founded:  "This game is brought to you by Surprise Industries. Learn more.", isInternational: true, read:false)]]
    
    var chapterNumberString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateOverlay(self.view)
        
        // This is required for the preferredStatusBarStyle override to work
        self.navigationController?.navigationBar.barStyle = .Black;
        
        // Change title font
        if let font = UIFont(name: "AvenirNext-Medium", size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        }
        
        // Load sample data
        //        self.data = initDataSet()
        
        // Initialize stuff
        //        setupSegmentedControl()
        setupTableView()
    }
    
    //    func initDataSet() -> [[Chapters]] {
    //        let usa = [
    //            Chapters(chapter: "Intro: The Rules", chapterNumber: "Intro", founded: "Everything you need to know to play the game (and beat the other players).", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 1: The Truth", chapterNumber: "1", founded: "Meet Kara Seinig, a journalist investigating the Cereal Killing case.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 2: The Facts", chapterNumber: "2", founded:  "Figure out the timeline, then try your hand at forensic handwriting analysis.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 3: The Suspects", chapterNumber: "3", founded:  "Figure out the timeline on the last day Marcus Hailey was seen alive.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 4: Lauralynn", chapterNumber: "4", founded:  "Meet Lauralynn, a sweet southern girl who may be hiding something.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 5: Vicky", chapterNumber: "5", founded: "Meet Vicky, Jeff’s ex, who may have wanted Marcus out of the picture.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 6: Paige", chapterNumber: "6", founded: "Meet Paige, a college professor who may have been involved with Marcus.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 7: Jason", chapterNumber: "7", founded:  "Meet Jason, a Study at Sea student who may have been Marcus’s rival.", isInternational: false, read:false),
    //            Chapters(chapter: "Ep. 8: The Reveal", chapterNumber: "8", founded:  "Time for the moment of truth: did you crack the case?", isInternational: false, read:false)
    //        ]
    //
    //        let international = [Chapters(chapter: "Surprise Industries", chapterNumber: "?",  founded:  "This game is brought to you by Surprise Industries. Learn more.", isInternational: true, read:false)]
    //
    //
    //        let dataSet = [usa, international]
    //
    //        return dataSet
    //    }
    //
    //    func setupSegmentedControl() {
    //        self.segmentedControl.items = ["All", "U.S.A.", "World"]
    //        self.segmentedControl.font = UIFont(name: "AvenirNext-Regular", size: 17)
    //        self.segmentedControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
    //        self.segmentedControl.selectedIndex = 0
    //        self.segmentedControl.addTarget(self, action: "segmentValueChanged:", forControlEvents: .ValueChanged)
    //    }
    //
    //    func segmentValueChanged(sender: AnyObject?) {
    //        self.tableView.reloadData()
    //    }
    
    func setupTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func shareWithFriends(sender: AnyObject) {
        
        let firstActivityItem = "Check out this murder mystery audio game from Surprise Industries! http://cerealthegame.com"
        
        let secondActivityItem : NSURL = NSURL(fileURLWithPath: "http://cerealthegame.com")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func openSafariBarButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://surpriseindustries.com")!)
    }
    
    // MARK: - Scroll view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = self.tableView.contentOffset.y
        let maxNegativeOffset = 80
        let percentageScrolledOfOffset = abs(offset / CGFloat(maxNegativeOffset))
        
        if offset < 0 {
            self.paragraph.alpha = 1 - percentageScrolledOfOffset
            //            self.segmentedControl.alpha = 1 - percentageScrolledOfOffset
            self.background.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + (percentageScrolledOfOffset / 5), 1 + (percentageScrolledOfOffset / 5))
        }
    }
    
    // MARK: - Table View DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //        let numberOfSections = self.segmentedControl.selectedIndex == 0 ? 2 : 1
        let numberOfSections = 2
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsInSection = 0
        
        switch (self.0/*segmentedControl.selectedIndex*/) {
        case 1:
            numberOfRowsInSection = self.data[0].count
            break;
            
        case 2:
            numberOfRowsInSection = self.data[1].count
            break;
            
        default:
            let allCampuses = [self.data[0], self.data[1]]
            numberOfRowsInSection = allCampuses[section].count
            break;
        }
        
        return numberOfRowsInSection
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chaptersCell", forIndexPath: indexPath) as! ChaptersCell
        cell.cityLabel?.adjustsFontSizeToFitWidth = true
        cell.cityLabel?.minimumScaleFactor = 0.5
        
        var currentCampus:Chapters?
        switch (self.0/*segmentedControl.selectedIndex*/) {
        case 1:
            currentCampus = self.data[0][indexPath.row]
            cell.cityLabel!.text = currentCampus!.chapter
            break;
            
        case 2:
            currentCampus = self.data[1][indexPath.row]
            cell.cityLabel!.text = currentCampus!.chapter
            break;
            
        default:
            let allCampuses = [self.data[0], self.data[1]]
            currentCampus = allCampuses[indexPath.section][indexPath.row]
            cell.cityLabel!.text = currentCampus!.chapter
            break;
        }
        if currentCampus!.read == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.tintColor = UIColor.greenColor()
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            cell.tintColor = UIColor(red: 128/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        }
        
        cell.cellCampus = currentCampus!
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("chaptersCell", forIndexPath: indexPath) as! ChaptersCell
        
        var currentCampus:Chapters?
        let allCampuses = [self.data[0], self.data[1]]
        currentCampus = allCampuses[indexPath.section][indexPath.row]
        cell.cityLabel!.text = currentCampus!.chapter
        cell.cellCampus = currentCampus!
        self.chapterNumberString = currentCampus!.chapterNumber
        
        if currentCampus!.chapterNumber == "?" {
            if let url = NSURL(string: "http://surpriseindustries.com") {
                currentCampus!.read = true
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                performSegueWithIdentifier("About", sender: NSURLRequest(URL: url))
            }
        } else if currentCampus!.chapterNumber == "Intro" {
            if let url = NSURL(string: "http://surpriseindustries.com") {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                currentCampus!.read = true
                performSegueWithIdentifier("Intro", sender: NSURLRequest(URL: url))
            }
        } else {
            if let url = NSURL(string: "http://insideyapper.com/Cereal/\(currentCampus!.chapterNumber).mp3") {
                currentCampus!.read = true
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                performSegueWithIdentifier("Audio", sender: url)
            }
        }
        
        self.data[indexPath.section][indexPath.row] = currentCampus!
        //        self.data[0][indexPath.row] = ()
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        var currentCampus:Chapters?
        let allCampuses = [self.data[0], self.data[1]]
        currentCampus = allCampuses[indexPath.section][indexPath.row]
        self.chapterNumberString = currentCampus!.chapterNumber
        
        if currentCampus!.chapterNumber == "?" {
            if let url = NSURL(string: "http://surpriseindustries.com") {
                currentCampus!.read = true
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                performSegueWithIdentifier("About", sender: NSURLRequest(URL: url))
            }
        } else if currentCampus!.chapterNumber == "Intro" {
            if let url = NSURL(string: "http://surpriseindustries.com") {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                currentCampus!.read = true
                performSegueWithIdentifier("Intro", sender: NSURLRequest(URL: url))
            }
        } else {
            if let url = NSURL(string: "http://insideyapper.com/Cereal/\(currentCampus!.chapterNumber).mp3") {
                currentCampus!.read = true
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                performSegueWithIdentifier("Audio", sender: url)
            }
        }
        self.data[indexPath.section][indexPath.row] = currentCampus!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if self.chapterNumberString == "!" {
            if let request = sender as? NSURLRequest {
                var destinationViewController = segue.destinationViewController as! AboutViewController
                destinationViewController.request = request
            } } else {
            if let request = sender as? NSURL {
                var destinationViewController = segue.destinationViewController as! AudioViewController
                destinationViewController.request = request
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
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
    
//    func swiftBird() {
//        var backstoryDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("backstoryDictionary")
//        var doorTwoStory = backstoryDict!["doorTwoStory"] as! String
//        var backstoryURL = backstoryDict!["doorTwoURL"] as! String
//        var doorTwoTitle = backstoryDict!["doorTwoTitle"] as! String
//        var discussionURL = backstoryDict!["doorTwoDiscussionURL"] as! String
//
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
//        var thirdButtonAction = UIAlertAction(title: "Read The Backstory", style: UIAlertActionStyle.Default) {
//            UIAlertAction in
//            self.displayAlert(title: doorTwoTitle, message: doorTwoStory, buttonText: "Thanks")
//        }
//        var fourthButtonAction = UIAlertAction(title: "View The Code", style: UIAlertActionStyle.Default) {
//            UIAlertAction in
//            var requestURL: String?
//            requestURL = backstoryURL
//            NSUserDefaults.standardUserDefaults().setObject(requestURL!, forKey: "urlForWebView")
//            
//            var webVC = self.storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebViewViewController
//            self.presentViewController(webVC, animated: true, completion: nil)
//        }
//        var fifthButtonAction = UIAlertAction(title: "Join The Discussion", style: UIAlertActionStyle.Default) {
//            UIAlertAction in
//            var requestURL: String?
//            requestURL = discussionURL
//            NSUserDefaults.standardUserDefaults().setObject(requestURL!, forKey: "urlForWebView")
//            
//            var webVC = self.storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebViewViewController
//            self.presentViewController(webVC, animated: true, completion: nil)
//        }
//
//        alert.addAction(secondButtonAction)
//        alert.addAction(thirdButtonAction)
//        alert.addAction(fifthButtonAction)
//        alert.addAction(fourthButtonAction)
//        alert.addAction(firstButtonAction)
//        alert.addAction(cancelButtonAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
    
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
                    println("Detail: Cereal Home Screen")
                    
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
