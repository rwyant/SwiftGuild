//
//  AudioViewController.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/7/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit
import MediaPlayer
//import AVFoundation

class AudioViewController: UIViewController {
    
//     var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var triangleView: UIImageView!
    @IBOutlet weak var rewind: UIImageView!
    @IBOutlet weak var fastForward: UIImageView!
    @IBOutlet weak var chapterTitleLabel: UILabel!
    @IBOutlet weak var episodeSubtitleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var emailButtonOutlet: UIButton!
    @IBOutlet weak var donationButtonOutlet: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var myUIImage: UIImage! = UIImage(named: "icon72x72@2x")
    var moviePlayer: MPMoviePlayerController?
    var userClickedPlayButton = false
    var alreadyInitiated = false
    var request: NSURL?
    var url:NSURL?
    var chapterNumber = ""
    
    
    func playAudio() {
        /*======================================
        ========================================
        ========================================
        ========================================
        IF YOU'RE READING THIS, YOU'VE PROBABLY
        NOTICED THAT THE AUDIO IS DIFFERENT.
        ========================================
        ========================================
        ========================================
        ========================================
        WE HAVE REMOVED THE PODCASTS TO FOCUS ON 
        CODING. EMAIL ROB AT ROB@GETYAPPER.COM 
        IF YOU'D LIKE TO BE CONNECTED TO THE 
        CREATORS OF THIS GAME. ✌️✌️✌️✌️✌️✌️✌️
        ========================================
        ========================================
        ========================================
        ======================================*/
        moviePlayer = MPMoviePlayerController(contentURL: self.url)
        if let player = moviePlayer {
            player.view.frame = CGRect(x: 0, y: 83, width: self.view.frame.width, height: 0)
//            player.prepareToPlay()
            player.scalingMode = .AspectFill
            self.view.addSubview(player.view)
        }
    }
    
    func playAudioTapGesture(sender: UITapGestureRecognizer) {
        if alreadyInitiated == false {
            if self.chapterNumber == "1" {
                turnSoundOn()
            }
            
            alreadyInitiated = true
            if let player = moviePlayer {
                player.play()
            }
            triangleView.image = UIImage(named: "pause")
            userClickedPlayButton = true
            UIApplication.sharedApplication().idleTimerDisabled = true
            initiateTapGestureRecognizer()
        } else {
            if let player = moviePlayer {
                player.play()
            }
            triangleView.image = UIImage(named: "pause")
            userClickedPlayButton = true
            UIApplication.sharedApplication().idleTimerDisabled = true
            initiateTapGestureRecognizer()
        }
    }
    
    func pauseAudioTapGesture(sender: UITapGestureRecognizer) {
        if let player = moviePlayer {
            player.pause()
        }
        triangleView.image = UIImage(named: "Triangle")
        userClickedPlayButton = false
        UIApplication.sharedApplication().idleTimerDisabled = false
        initiateTapGestureRecognizer()
    }
    
    func showActivityIndicatory(uiView: UIView) {
        var container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(white:0.2, alpha:0.0)
        container.tag = 100
        
        var loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 120, 120)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(white:0.2, alpha:0.6)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicatory(uiView: UIView) {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            println("No!")
        }
    }
    
    
    func fastForward(sender: UILongPressGestureRecognizer) {
        if alreadyInitiated == true {
            if let player = moviePlayer {
                if (sender.state == UIGestureRecognizerState.Began) {
                    player.beginSeekingForward()
                    showActivityIndicatory(self.view)
                } else if (sender.state == UIGestureRecognizerState.Ended) {
                    player.endSeeking()
                    hideActivityIndicatory(self.view)
                }
            }
        }
    }
    
    func reverse(sender: UILongPressGestureRecognizer) {
        if alreadyInitiated == true {
            if let player = moviePlayer {
                if (sender.state == UIGestureRecognizerState.Began) {
                    player.beginSeekingBackward()
                    showActivityIndicatory(self.view)
                } else if (sender.state == UIGestureRecognizerState.Ended) {
                    player.endSeeking()
                    hideActivityIndicatory(self.view)
                }
            }
        }
    }
    
    func pushFFRewindWarning(sender: UITapGestureRecognizer) {
        if alreadyInitiated == true {
        displayAlert(title: "Hey!", message: "To access this feature, please press and hold the arrow.", buttonText: "Thank you")
        }
    }
    
    func initiateTapForFFAndReverse() {
        let ff = UILongPressGestureRecognizer(target: self, action: "fastForward:")
        let reverse = UILongPressGestureRecognizer(target: self, action: "reverse:")
        self.fastForward.addGestureRecognizer(ff)
        self.rewind.addGestureRecognizer(reverse)
        let ffNotification = UITapGestureRecognizer(target:self, action: "pushFFRewindWarning:")
        let rewindNotification = UITapGestureRecognizer(target:self, action: "pushFFRewindWarning:")
        self.fastForward.addGestureRecognizer(ffNotification)
        self.rewind.addGestureRecognizer(rewindNotification)
        fastForward.userInteractionEnabled = true
        rewind.userInteractionEnabled = true
        
        
    }
    
    func initiateTapGestureRecognizer() {
            if userClickedPlayButton == false {
                let tapTriangle = UITapGestureRecognizer(target: self, action: "playAudioTapGesture:")
                self.triangleView.addGestureRecognizer(tapTriangle)
            } else {
                let tapTriangle = UITapGestureRecognizer(target: self, action: "pauseAudioTapGesture:")
                self.triangleView.addGestureRecognizer(tapTriangle)
            }
        triangleView.userInteractionEnabled = true
    }
    
    func changeChapterLabel() {
        var chapterLabelText = ""
        switch self.chapterNumber {
//        case "I" : chapterLabelText = "IMPORTANT: You must email evidence to all players present."
        case "1" : chapterLabelText = "Meet Kara Seinig, a journalist investigating the Cereal Killing case."
        case "2" : chapterLabelText = "Figure out the timeline on the last day Marcus Hailey was seen alive."
        case "3" : chapterLabelText = "Meet the cast of characters who might have something to do with the murder."
        case "4" : chapterLabelText = "Meet Lauralynn, a sweet southern girl who may be hiding something."
        case "5" : chapterLabelText = "Meet Vicky, Jeff’s ex, who may have wanted Marcus out of the picture."
        case "6" : chapterLabelText = "Meet Paige, a college professor who may have been involved with Marcus."
        case "7" : chapterLabelText = "Meet Jason, a Study at Sea student who may have been Marcus’s rival."
        case "8" : chapterLabelText = "Finalize your answers to The Big 12 Questions and let's discuss."
        case "9" : chapterLabelText = " If you liked the game, we ask that you make a minimal donation (suggested $2 per person). Donations will go towards creating new games and experiences that help make the world a more surprising place. Those who donate may be offered the chance to test our new products!"
//        case "!" : chapterLabelText = "If you like the game, we ask that you make a minimal donation. We're a small team of experienced designers out to make the world a more surprising place."
        default : break
        }
        self.chapterLabel.text = chapterLabelText
    }
    
    func changeEpisodeSubtitle() {
        var episodeSubtitle = ""
        switch self.chapterNumber {
//        case "I" : episodeSubtitle = "The Rules"
        case "1" : episodeSubtitle = "The Truth"
        case "2" : episodeSubtitle = "The Facts"
        case "3" : episodeSubtitle = "The Suspects"
        case "4" : episodeSubtitle = "Lauralynn"
        case "5" : episodeSubtitle = "Vicky"
        case "6" : episodeSubtitle = "Paige"
        case "7" : episodeSubtitle = "Jason"
        case "8" : episodeSubtitle = "Final Discussion"
        case "9" : episodeSubtitle = "The Reveal"
//        case "!" : episodeSubtitle = "About"
        default : break
        }
        self.episodeSubtitleLabel.text = episodeSubtitle
    }
    
//    func displayAlert(#title: String, message: String, buttonText: String) {
    func displayAlert(#title: String, message: String, buttonText: String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        // We can add other buttons
        alert.addButtonWithTitle(buttonText)
        // We call the show() method once we have all of our alert properties set
        alert.show()
    }
    
    @IBAction func donationNotification(sender: AnyObject) {
        donateBitches()
        println("this happened 1")
    }
    
    func donateBitches() {
        displayAlert(title: "Donation Box", message: "Thank you for your generosity! This feature is currently under construction, but please email us with any feedback or stories from your experience: robyn@surpriseindustries.com", buttonText: "Thanks for your support")
    }
    
    func turnSoundOn() {
        displayAlert(title: "🔊 Turn Audio On 🔊", message: "Please make sure your phone's audio is turned 'ON'. Check the 'Ring/Silent switch' and 'Volume' on the side of your phone.", buttonText: "Thanks")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateTapGestureRecognizer()
        initiateTapForFFAndReverse()
        
        initiateOverlay(self.view)
        
        if let request = self.request {
            self.url = request
            var stringUrl = String("\(url)")
            var numberFromUrl = Array(stringUrl)[40]
            self.chapterNumber = String(numberFromUrl)
        }
        
        if UIScreen.mainScreen().bounds.size.height == 480 {
            self.chapterLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        }
        
        // Do any additional setup after loading the view.
        self.chapterTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 46)
        self.episodeSubtitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        self.chapterLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
        if chapterNumber == "I" {
            self.chapterTitleLabel.text = "Introduction"
            emailButtonOutlet.hidden = false
            emailButtonOutlet.userInteractionEnabled = true
        } else if chapterNumber == "!" {
            self.chapterTitleLabel.text = "About Us"
        } else if chapterNumber == "9" {
            donationButtonOutlet.hidden = false
            donationButtonOutlet.userInteractionEnabled = true
            self.chapterTitleLabel.text = "Episode \(chapterNumber)"
            self.chapterLabel.font = UIFont(name: "AvenirNext-Regular", size: 13)
        } else {
            self.chapterTitleLabel.text = "Episode \(chapterNumber)"
        }
        playAudio()
        changeChapterLabel()
        changeEpisodeSubtitle()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    println("Detail: \(self.chapterTitleLabel.text!)")
                    
                    self.displayAlert(title: "Feedback Sent", message: "Thank you for your feedback! \n\nWe will share your comments with the developer of this project.", buttonText: "Cool")
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(loadWebsiteAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}