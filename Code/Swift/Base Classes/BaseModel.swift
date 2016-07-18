//
//  BaseModel.swift
//  PW_Swift_HW
//
//  Created by CC Cooper on 7/5/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel : NSObject, Mappable
{
    // MARK: - Mappable
    
    required init?(_ map: Map) {
        
    }
    
    
    func mapping(map: Map) {

    }
    
    static func objectForMapping(map: Map) -> Mappable? {
    
        return nil;
    }
    
}