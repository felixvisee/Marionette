//
//  CoreImageExtensions.swift
//  Marionette
//
//  Created by Felix Jendrusch on 2/4/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func pack(value: CIImage) -> AnyObject {
    return value
}

public func unpack(value: AnyObject) -> CIImage {
    return value as CIImage
}

public func pack(value: CIFilter) -> AnyObject {
    return value
}

public func unpack(value: AnyObject) -> CIFilter {
    return value as CIFilter
}
