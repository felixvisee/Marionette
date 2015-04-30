//
//  CoreAnimationExtensions.swift
//  Marionette
//
//  Created by Felix Jendrusch on 2/4/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func pack(value: CATransform3D) -> AnyObject {
    return NSValue(CATransform3D: value)
}

public func unpack(value: AnyObject) -> CATransform3D {
    return (value as! NSValue).CATransform3DValue
}
