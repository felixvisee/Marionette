//
//  MediaTimingFunction.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/29/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public enum MediaTimingFunction: Equatable {
    case Linear
    case EaseIn
    case EaseOut
    case EaseInEaseOut
    case Default
    case CubicBezier(c1x: Float, c1y: Float, c2x: Float, c2y: Float)

    public var name: String! {
        switch self {
        case .Linear:
            return kCAMediaTimingFunctionLinear
        case .EaseIn:
            return kCAMediaTimingFunctionEaseIn
        case .EaseOut:
            return kCAMediaTimingFunctionEaseOut
        case .EaseInEaseOut:
            return kCAMediaTimingFunctionEaseInEaseOut
        case .Default:
            return kCAMediaTimingFunctionDefault
        default:
            return nil
        }
    }

    public func function() -> CAMediaTimingFunction {
        switch self {
        case .CubicBezier(let c1x, let c1y, let c2x, let c2y):
            return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)
        default:
            return CAMediaTimingFunction(name: name)
        }
    }
}

public func ==(lhs: MediaTimingFunction, rhs: MediaTimingFunction) -> Bool {
    switch (lhs, rhs) {
    case (.CubicBezier(let lc1x, let lc1y, let lc2x, let lc2y), .CubicBezier(let rc1x, let rc1y, let rc2x, let rc2y)):
        return lc1x == rc1x && lc1y == rc1y && lc2x == rc2x && lc2y == rc2y
    default:
        return lhs.name == rhs.name
    }
}
