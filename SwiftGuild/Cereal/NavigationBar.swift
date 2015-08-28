//
//  NavigationBar.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/7/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    func initialize() {
        self.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = UIImage()
        self.translucent = true
    }
    
}
