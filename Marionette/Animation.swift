//
//  Animation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import Foundation

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
    public var fillMode: FillMode! = .Removed

    private init() {}

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

        if let fillMode = self.fillMode {
            animation.fillMode = fillMode.name
        }
    }
}

public class PropertyAnimation<T>: Animation {
    public var additive: Bool = false
    public var cumulative: Bool = false
    public var valueFunction: ValueFunction! = nil

    internal func animationForProperty(property: Property<T>) -> CAPropertyAnimation! {
        return nil
    }

    internal func populateAnimation(animation: CAPropertyAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation)

        animation.keyPath = property.keyPath

        animation.additive = additive
        animation.cumulative = cumulative

        if let valueFunction = self.valueFunction {
            animation.valueFunction = valueFunction.function()
        }
    }
}

public class BasicAnimation<T>: PropertyAnimation<T> {
    public var fromValue: T! = nil
    public var toValue: T! = nil
    public var byValue: T! = nil

    override public init() {}

    public init(fromValue: T! = nil, toValue: T! = nil, byValue: T! = nil, withDuration aDuration: CFTimeInterval? = nil) {
        super.init()

        self.fromValue = fromValue
        self.toValue = toValue
        self.byValue = byValue

        if let duration = aDuration {
            self.duration = duration
        }
    }

    override internal func animationForProperty(property: Property<T>) -> CABasicAnimation! {
        var animation = CABasicAnimation()
        populateAnimation(animation, forProperty: property)
        return animation
    }

    internal func populateAnimation(animation: CABasicAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation, forProperty: property)

        if let fromValue = self.fromValue {
            animation.fromValue = property.pack(fromValue)
        }

        if let toValue = self.toValue {
            animation.toValue = property.pack(toValue)
        }

        if let byValue = self.byValue {
            animation.byValue = property.pack(byValue)
        }
    }
}

public func ... <T>(lhs: T!, rhs: T!) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs, toValue: rhs)
}

// TODO: Precedence, Associativity
prefix operator ... { }

prefix public func ... <T>(rhs: T!) -> BasicAnimation<T> {
    return BasicAnimation(toValue: rhs)
}

// TODO: Precedence, Associativity
postfix operator ... { }

postfix public func ... <T>(lhs: T!) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs)
}

// TODO: Precedence, Associativity
infix operator ~ { }

public func ~ <T>(lhs: Range<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    var animation = BasicAnimation(fromValue: lhs.startIndex, toValue: lhs.endIndex)
    animation.timingFunction = rhs
    return animation
}

public func ~ <I: IntervalType, T where I.Bound == T>(lhs: I, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    var animation = BasicAnimation(fromValue: lhs.start, toValue: lhs.end)
    animation.timingFunction = rhs
    return animation
}

public func ~ <A: Animation>(lhs: A, rhs: MediaTimingFunction) -> A {
    lhs.timingFunction = rhs
    return lhs
}
