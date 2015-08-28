//
//  DonationViewController.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/22/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit
//import StoreKit

class DonationViewController: UIViewController/*, SKProductsRequestDelegate, SKPaymentTransactionObserver*/ {
    
    @IBOutlet weak var tier1Outlet: UIButton!
    @IBOutlet weak var tier2Outlet: UIButton!
    @IBOutlet weak var tier3Outlet: UIButton!
    @IBOutlet weak var tier4Outlet: UIButton!
    
//    var list = [SKProduct]()
//    var p = SKProduct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateOverlay(self.view)
        
//        tier1Outlet.enabled = false
//        tier2Outlet.enabled = false
//        tier3Outlet.enabled = false
//        tier4Outlet.enabled = false
//        
//        //Set IAP
//        if(SKPaymentQueue.canMakePayments()) {
//            println("IAP is enabled, loading")
//            var productID:NSSet = NSSet(objects: "com.surpriseindustries.robyn.tier1", "com.surpriseindustries.robyn.tier2", "com.surpriseindustries.robyn.tier3", "com.surpriseindustries.robyn.tier4")
//            var requests: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>)
//            requests.delegate = self
//            requests.start()
//        } else {
//            println("please enable IAPs")
//        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tier1Button(sender: UIButton) {
        donateAlert()
//        for product in list {
//            var prodID = product.productIdentifier
//            if(prodID == "com.surpriseindustries.robyn.tier1") {
//                p = product
//                buyProduct()
//                break
//            }
//        }
    }
    
    @IBAction func tier2Button(sender: UIButton) {
        donateAlert()
//        for product in list {
//            var prodID = product.productIdentifier
//            if(prodID == "com.surpriseindustries.robyn.tier2") {
//                p = product
//                buyProduct()
//                break
//            }
//        }
    }
    
    @IBAction func tier3Button(sender: UIButton) {
        donateAlert()
//        for product in list {
//            var prodID = product.productIdentifier
//            if(prodID == "com.surpriseindustries.robyn.tier3") {
//                p = product
//                buyProduct()
//                break
//            }
//        }
    }
    
    @IBAction func tier4Button(sender: UIButton) {
        donateAlert()
//        for product in list {
//            var prodID = product.productIdentifier
//            if(prodID == "com.surpriseindustries.robyn.tier4") {
//                p = product
//                buyProduct()
//                break
//            }
//        }
    }
    func donateAlert() {
        let alert = UIAlertController()
        alert.title = "Donation Box"
        alert.message = "Thank you for your generosity! We hope you enjoyed your experience. \n\nSince this is a SANDBOX app (embedded into the SwiftGuild App) we are not accepting donations from this platform, but you can download 'Cereal The Game' in the iOS App Store -- the donation is fully funcitonal there. \n\nOh, and also, please tell your friends about how much fun you had!"
        var cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("Share Button cancelled.")
        }
        var firstButtonAction = UIAlertAction(title: "Link to the App Store", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            UIApplication.sharedApplication().openURL(NSURL(string:"https://itunes.apple.com/us/app/cereal-the-game/id981244698?mt=8")!)
        }
        alert.addAction(firstButtonAction)
        alert.addAction(cancelButtonAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//    func displayAlert(#title: String, message: String, buttonText: String) {
//        let alert = UIAlertView()
//        alert.title = title
//        alert.message = message
//        // We can add other buttons
//        alert.addButtonWithTitle(buttonText)
//        // We call the show() method once we have all of our alert properties set
//        alert.show()
//    }
//    
//    func donateBitches() {
//        displayAlert(title: "Donation Box", message: "Thank you for your generosity! We hope you enjoyed your experience in Cereal The Game. Please tell your friends about how much fun you had!", buttonText: "Thanks for your support")
//    }
    
//    @IBAction func restorePurchasesButton(sender: UIButton) {
//        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
//        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
//    }
//
//    func buyProduct() {
//        println("buy " + p.productIdentifier)
//        var pay = SKPayment(product: p)
//        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
//        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
//    }
//    
//    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
//        println("product request")
//        var myProduct = response.products
//        println(response.products.count)
//        
//        for product in myProduct {
//            println("product added")
//            println(product.productIdentifier)
//            println(product.localizedTitle)
//            println(product.localizedDescription)
//            println(product.price)
//            
//            list.append(product as! SKProduct)
//        }
//        
//        tier1Outlet.enabled = true
//        tier2Outlet.enabled = true
//        tier3Outlet.enabled = true
//        tier4Outlet.enabled = true
//    }
//    
//    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
//        println("transactions Restored")
//        
//        var purchasedItemIDs = []
//        for transaction in queue.transactions {
//            var t: SKPaymentTransaction = transaction as! SKPaymentTransaction
//            
//            let prodID = t.payment.productIdentifier as String
//            
//            switch prodID {
//            case "com.surpriseindustries.robyn.tier1":
//                println("Purchase of tier 1")
//                donateBitches()
//            case "com.surpriseindustries.robyn.tier2":
//                println("Purchase of tier 2")
//                donateBitches()
//            case "com.surpriseindustries.robyn.tier3":
//                println("Purchase of tier 3")
//                donateBitches()
//            case "com.surpriseindustries.robyn.tier4":
//                println("Purchase of tier 4")
//                donateBitches()
//            default: println("IAP not setup")
//            }
//        }
//    }
//    
//    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
//        println("add payment")
//        for transaction:AnyObject in transactions {
//            var trans = transaction as! SKPaymentTransaction
//            println(trans.error)
//            
//            switch trans.transactionState {
//            case .Purchased:
//                println("buy, okay to unlock iap here")
//                println(p.productIdentifier)
//                
//                let prodID = p.productIdentifier as String
//                switch prodID {
//                case "com.surpriseindustries.robyn.tier1":
//                    println("Purchase of tier 1")
//                case "com.surpriseindustries.robyn.tier2":
//                    println("Purchase of tier 2")
//                case "com.surpriseindustries.robyn.tier3":
//                    println("Purchase of tier 3")
//                case "com.surpriseindustries.robyn.tier4":
//                    println("Purchase of tier 4")
//                default: println("IAP not setup")
//                }
//                queue.finishTransaction(trans)
//                break
//                
//            case .Failed:
//                println("buy error")
//                queue.finishTransaction(trans)
//                break
//                
//            default:
//                println("default")
//                break
//            }
//        }
//    }
//    
//    func finishTransaction(trans:SKPaymentTransaction) {
//        println("finish trans")
//    }
//    
//    func paymentQueue(queue: SKPaymentQueue!, removedTransactions transactions: [AnyObject]!) {
//        println("removed trans")
//    }
    
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
                    println("Detail: Cereal Donation")
                    
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
