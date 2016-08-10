//
//  UIViewExt.swift
//  
//
//  Created by CC Cooper on 7/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import UIKit


extension UIView {

    // MARK: - load nib file
    func loadFromNib(nibName: String)
    {
        let subviews = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil)
        if let view = subviews.first{
            
            let topView = view as! UIView
            topView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            self.addSubview(topView)
            topView.frame = self.bounds
        }
    }
    
    
    // MARK: - frame properties
    var frameX: CGFloat {
        get{
            return self.frame.origin.x
        }
        
        set{
            self.frame.origin.x = newValue
        }
    }
    
    var frameY: CGFloat{
        get{
            return self.frame.origin.y
        }
        
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var frameWidth: CGFloat{
    
        get{
            return self.frame.size.width
        }
        
        set{
            self.frame.size.width = newValue
        }
    }
    
    var frameHeight: CGFloat{
        get {
            return self.frame.size.height
        }
        
        set{
            self.frame.size.height = newValue
        }
    }
    
    var frameSize: CGSize {
        get {
            return self.frame.size
        }
        
        set {
            self.frame.size = newValue
        }
    }
    
    
    var frameOrigin: CGPoint {
        get{
            return self.frame.origin
        }
        
        set{
            self.frame.origin = newValue
        }
    }
    
    var minX: CGFloat {
        get {
            return self.frameX
        }
        
        set {
            self.frameX = newValue
        }
    }
    
    var minY: CGFloat {
        
        get{
            return self.frameY
        }
        
        set {
            self.frameY = newValue
        }
    }
    
    var maxX: CGFloat{
        get{
            return CGRectGetMaxX(self.frame)
        }
        
        set {
            self.frame.origin.x = newValue - self.frameWidth
        }
    }

    var maxY: CGFloat{
        get{
            return CGRectGetMaxY(self.frame)
        }
        
        set{
            self.frame.origin.y = newValue - self.frameHeight
        }
    }
    
    // MARK: - Background gradient color
    
    func setBackgroundGradienVertical(color:UIColor)
    {
        self.setBackgroundGradienVertical(color.colorWithAlphaComponent(0.0), bottomColor: color)
    }
    
    func setBackgroundGradienVertical(topColor:UIColor, bottomColor:UIColor)
    {
        self.setBackgroundGradien(topColor, bottomColor: bottomColor, startPoint: CGPointMake(0.5, 0.0), endPoint: CGPointMake(0.5, 1.0))
    }
    
    /*
        (0, 0) is the top-left corner of the view
        startPoint is where the topColor will star
        endPoint is where the bottomColor will end
     */
    
    func setBackgroundGradien(topColor:UIColor, bottomColor:UIColor, startPoint:CGPoint, endPoint:CGPoint) -> CAGradientLayer
    {        
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = [topColor.CGColor, bottomColor.CGColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, atIndex: 0)
        return gradient
    }
    


}
