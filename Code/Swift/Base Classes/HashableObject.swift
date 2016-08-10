//
//  HashableObject.swift
//
//  Created by CC Cooper on 7/25/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation


public protocol DefaultHashable:Hashable {
    func isEqual(_:Self) ->Bool
}


public class HashableObject: DefaultHashable {
    

    public var hashValue: Int {
        
        return TypeString(self).hashValue + unsafeAddressOf(self).hashValue
    }
    
    public func isEqual(to: HashableObject) ->Bool{
        return hashValue == to.hashValue
    }
}


public func == <T:HashableObject> (lhs: T, rhs: T) -> Bool
{
    return lhs.isEqual(rhs)
}