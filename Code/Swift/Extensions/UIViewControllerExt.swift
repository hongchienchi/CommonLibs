//
//  UIViewControllerExt.swift
//  
//
//  Created by CC Cooper on 7/12/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import UIKit

extension UIViewController {

    func visibleNavigationBar(visible:Bool)
    {
        if visible {
            self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.translucent = false
        }
        else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
        }

    }
}
