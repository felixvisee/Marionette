//
//  Animation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class Animation: MediaTiming {
    // Animation
    public var timingFunction: MediaTimingFunction! = nil
    public var removedOnCompletion: Bool = true

    // MediaTiming
    public var beginTime: CFTimeInterval = 0
    public var duration: CFTimeInterval = 0
    public var speed: Float = 1
    public var timeOffset: CFTimeInterval = 0
    public var repeatCount: Float = 0
    public var repeatDuration: CFTimeInterval = 0
    public var autoreverses: Bool = false
    public var fillMode: FillMode = .Removed

    internal init() {}

    internal func populateAnimation(animation: CAAnimation) {
        if let timingFunction = self.timingFunction {
            animation.timingFunction = timingFunction.function()
        }

        animation.removedOnCompletion = removedOnCompletion
        animation.beginTime = beginTime
        animation.duration = duration
        animation.speed = speed
        animation.timeOffset = timeOffset
        animation.repeatCount = repeatCount
        animation.repeatDuration = repeatDuration
        animation.autoreverses = autoreverses
        animation.fillMode = fillMode.name
    }
}

infix operator ~ { precedence 131 }

public func ~ <A: Animation>(lhs: A, rhs: MediaTimingFunction) -> A {
    lhs.timingFunction = rhs
    return lhs
}
