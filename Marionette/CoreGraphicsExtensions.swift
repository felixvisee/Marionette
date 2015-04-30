//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.

import UIKit

public func pack(value: CGFloat) -> AnyObject {
    return NSNumber(double: Double(value))
}

public func unpack(value: AnyObject) -> CGFloat {
    return CGFloat((value as! NSNumber).doubleValue)
}

public func pack(value: CGColor) -> AnyObject {
    return value
}

public func unpack(value: AnyObject) -> CGColor {
    return value as! CGColor
}

public func pack(value: CGPoint) -> AnyObject {
    return NSValue(CGPoint: value)
}

public func unpack(value: AnyObject) -> CGPoint {
    return (value as! NSValue).CGPointValue()
}

public func pack(value: CGSize) -> AnyObject {
    return NSValue(CGSize: value)
}

public func unpack(value: AnyObject) -> CGSize {
    return (value as! NSValue).CGSizeValue()
}

public func pack(value: CGRect) -> AnyObject {
    return NSValue(CGRect: value)
}

public func unpack(value: AnyObject) -> CGRect {
    return (value as! NSValue).CGRectValue()
}

public func pack(value: CGPath) -> AnyObject {
    return value
}

public func unpack(value: AnyObject) -> CGPath {
    return value as! CGPath
}
