//
//  FoundationExtensions.swift
//  Marionette
//
//  Created by Felix Jendrusch on 2/4/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func pack(value: Bool) -> AnyObject {
    return NSNumber(bool: value)
}

public func unpack(value: AnyObject) -> Bool {
    return (value as! NSNumber).boolValue
}

public func pack(value: Float) -> AnyObject {
    return NSNumber(float: value)
}

public func unpack(value: AnyObject) -> Float {
    return (value as! NSNumber).floatValue
}
