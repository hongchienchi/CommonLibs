//
//  ToolBox.swift
//  
//
//  Created by CC Cooper on 7/26/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation


func TypeString(any: Any) -> String {
    return (any is Any.Type) ? "\(any)" : "\(any.dynamicType)"
}
