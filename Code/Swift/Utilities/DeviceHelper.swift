//
//  DeviceHelper.swift
//  
//
//  Created by CC Cooper on 7/11/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation
import UIKit


class DeviceHelper
{
    class func deviceSize() -> CGSize
    {
        let size = UIScreen.mainScreen().bounds.size

        var returnSize = CGSize()
        
        
        let orientation = UIDevice.currentDevice().orientation

        let isPortrait = UIDeviceOrientationIsPortrait(orientation)
        
        if isPortrait {
            if size.height > size.width {
                returnSize = size
            }
            else{
                returnSize = CGSizeMake(size.height, size.width)
            }
        }
        else{
            if size.width > size.height {
                returnSize = size
            }
            else{
                returnSize = CGSizeMake(size.height, size.width)
            }
        }

        return returnSize
    }
    
    class func deviceWidth() -> CGFloat
    {
        return self.deviceSize().width
    }
    
    class func deviceHeight() -> CGFloat
    {
        return self.deviceSize().height
    }
    
    class func isIphone() -> Bool
    {
        return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
    }
    
    class func isPad() -> Bool
    {
        return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
    }
    
    class func iosVersion() -> CGFloat
    {
        let versionString = UIDevice.currentDevice().systemVersion
        if let version = Double(versionString){
        
            return CGFloat(version)
        }
        
        return 0.0
    }
    
    class func isPhone4() -> Bool
    {
        return DeviceHelper.isIphone() && DeviceHelper.deviceHeight() == 480.0
    }
    
    class func isPhone5() -> Bool
    {
        return DeviceHelper.isIphone() && DeviceHelper.deviceHeight() == 560.0
    }
    
    class func isPhone6() -> Bool
    {
        return DeviceHelper.isIphone() && DeviceHelper.deviceHeight() == 667.0
    }
    
    class func isPhone6Plus() -> Bool
    {
        return DeviceHelper.isIphone() && DeviceHelper.deviceHeight() == 736.0
    }
    
    
}