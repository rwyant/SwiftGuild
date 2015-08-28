//
//  SegmentedControl.swift
//  Cereal The Game
//
//  Created by Rob Wyant on 3/7/15.
//  Copyright (c) 2015 Rob Wyant. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControl: UIControl {
    
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    var items:[String] = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            setupLabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupComponent()
    }
    
    func setupComponent() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        layer.borderWidth = 1.0
        
        backgroundColor = UIColor.clearColor()
        
        setupLabels()
        self.insertSubview(self.thumbView, atIndex: 0)
    }
    
    func setupLabels() {
        for label in self.labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for index in 1...self.items.count {
            let label = UILabel(frame: CGRectZero)
            label.text = self.items[index - 1]
            label.textAlignment = .Center
            label.textColor = UIColor(white: 0.5, alpha: 1.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(label)
            
            labels.append(label)
        }
    }
    
    func displayNewSelectedIndex() {
        var label = labels[self.selectedIndex]
        self.thumbView.frame = label.frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = CGRectGetWidth(selectedFrame) / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelheight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...self.labels.count - 1 {
            let label = self.labels[index]
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelheight)
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let location = touch.locationInView(self)
        
        var calculatedIndex: Int?
        for (index, item) in enumerate(self.labels) {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
    }
}
