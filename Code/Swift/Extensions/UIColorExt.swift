//
//  UIColorExt.swift
//
//  Created by CC Cooper on 7/27/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import UIKit
//import Foundation


extension UIColor {

    // without @nonobjc, Swift will try to generate a dynamic accessor for the static property for Obj-C compatibility, since the class inherits from UIColor which is a Obj-C classa.
    @nonobjc static var s_colorCached = NSMutableDictionary()
    
    
    class func colorWithRGBA(hexInt: UInt32) -> UIColor
    {
        let r = (hexInt >> 16) & 0xFF
        let g = (hexInt >> 8) & 0xFF
        let b = (hexInt) & 0xFF
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
        
    }
    
    class func colorWithHexString (hexString: String) -> UIColor?
    {

        guard hexString.characters.count > 0 else {
            return nil
        }
        
        if let cachedColor = UIColor.s_colorCached.objectForKey(hexString){
            return (cachedColor as! UIColor)
        }
        
        let scanner = NSScanner(string: hexString)
        
        var hexNumber = UInt32()
        
        guard scanner.scanHexInt(&hexNumber) == true else {
            return nil
        }
        
        let color = self.colorWithRGBA(hexNumber)
        UIColor.s_colorCached.setValue(color, forKey: hexString)
        
        return color
        
    }
}