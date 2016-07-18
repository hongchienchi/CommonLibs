//
//  imagesCacheManager.swift
//  PW_Swift_HW
//
//  Created by CC Cooper on 7/11/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation
import UIKit

class ImagesCacheManager {

    static let sharedInstance = ImagesCacheManager()
    
    var cache = [String:UIImage]()
    
    func loadImage(urlString:String?, completion:((image:UIImage?, error:NSError?)->Void)?)
    {
        DataController.sharedInstance.loadImage(urlString, completion:completion)
        
    }
}