//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.

import UIKit

public class Animation: MediaTiming {
    // Animation
    public var timingFunction: MediaTimingFunction? = nil
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
        animation.timingFunction = self.timingFunction?.function()
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

infix operator ~ {
    associativity none
    precedence 131
}

public func ~ <A: Animation>(lhs: A, rhs: MediaTimingFunction) -> A {
    lhs.timingFunction = rhs
    return lhs
}
