//
//  Logic.swift
//  Venbot
//
//  Created by Rob Wyant on 8/13/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//

import Foundation

class Logic {
    func getPlayerInfo(accessToken:String ,completionHandler: (JSON?, NSError?) -> ()) {
        var data: JSON?
        
        var parameters = [
            "access_token" : accessToken
        ]
        
        request(.GET, "https://api.venmo.com/v1/me", parameters: parameters)
            .responseJSON { (request, response, tempJSON, error) in
                if tempJSON != nil {
                    data = JSON(tempJSON!)
                } else {
                    println("Error \(error)")
                }
                
                completionHandler(data, error)
        }
    }
    
    func getTransactionInfo(accessToken:String ,completionHandler: (JSON?, NSError?) -> ()) {
        var data: JSON?
        
        var parameters = [
            "access_token" : accessToken
        ]
        
        request(.GET, "https://api.venmo.com/v1/payments", parameters: parameters)
            .responseJSON { (request, response, tempJSON, error) in
                if tempJSON != nil {
                    data = JSON(tempJSON!)
                } else {
                    println("Error \(error)")
                }
                
                completionHandler(data, error)
        }
    }
    
//        request(.GET, "https://api.venmo.com/v1/payments", parameters: parameters, encoding: nil)
        //        request(.GET, "https://api.venmo.com/v1/payments", parameters: parameters)
        //
        //        request(.GET, "https://api.venmo.com/v1/payments", parameters: parameters)
//                    .response { (_, response, results, _) -> Void in
//                    transactions.text = results
//                }
}