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
        animation.fillMode = fillMode.name
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

public enum CalculationMode {
    case Linear
    case Discrete
    case Paced
    case Cubic
    case CubicPaced

    public var name: String {
        switch self {
        case .Linear:
            return kCAAnimationLinear
        case .Discrete:
            return kCAAnimationDiscrete
        case .Paced:
            return kCAAnimationPaced
        case .Cubic:
            return kCAAnimationCubic
        case .CubicPaced:
            return kCAAnimationCubicPaced
        }
    }
}

public enum RotationMode {
    case Auto
    case AutoReverse

    public var name: String {
        switch self {
        case .Auto:
            return kCAAnimationRotateAuto
        case .AutoReverse:
            return kCAAnimationRotateAutoReverse
        }
    }
}

public class KeyframeAnimation<T>: PropertyAnimation<T> {
    public var values: [T]! = nil
    public var path: CGPath! = nil
    public var keyTimes: [Float]! = nil
    public var timingFunctions: [MediaTimingFunction]! = nil
    public var calculationMode: CalculationMode = .Linear
    public var tensionValues: [Float]! = nil
    public var continuityValues: [Float]! = nil
    public var biasValues: [Float]! = nil
    public var rotationMode: RotationMode! = nil

    override public init() {}

    public init(keyFrames: [(Float, T)], withDuration aDuration: CFTimeInterval? = nil) {
        super.init()

        values = []; keyTimes = []
        for (keyTime, value) in keyFrames {
            values.append(value)
            keyTimes.append(keyTime)
        }

        if let duration = aDuration {
            self.duration = duration
        }
    }

    public init(path: CGPath, withDuration aDuration: CFTimeInterval? = nil) {
        super.init()

        self.path = path

        if let duration = aDuration {
            self.duration = duration
        }
    }

    override internal func animationForProperty(property: Property<T>) -> CAKeyframeAnimation! {
        var animation = CAKeyframeAnimation()
        populateAnimation(animation, forProperty: property)
        return animation
    }

    internal func populateAnimation(animation: CAKeyframeAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation, forProperty: property)

        animation.values = values?.map({ property.pack($0) })
        animation.path = path
        animation.keyTimes = keyTimes
        animation.timingFunctions = timingFunctions?.map({ $0.function() })
        animation.calculationMode = calculationMode.name
        animation.tensionValues = tensionValues
        animation.continuityValues = continuityValues
        animation.biasValues = biasValues
        animation.rotationMode = rotationMode?.name
    }
}

public func ... <T>(lhs: T, rhs: T) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs, toValue: rhs)
}

// TODO: Precedence, Associativity
prefix operator ... { }

prefix public func ... <T>(rhs: T) -> BasicAnimation<T> {
    return BasicAnimation(toValue: rhs)
}

// TODO: Precedence, Associativity
postfix operator ... { }

postfix public func ... <T>(lhs: T) -> BasicAnimation<T> {
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

public func ~ <T>(lhs: [(Float, T)], rhs: MediaTimingFunction) -> KeyframeAnimation<T> {
    var animation = KeyframeAnimation(keyFrames: lhs)
    animation.timingFunction = rhs
    return animation
}

public func ~ <T>(lhs: [(Float, T)], rhs: [MediaTimingFunction]) -> KeyframeAnimation<T> {
    return KeyframeAnimation(keyFrames: lhs) ~ rhs
}

public func ~ <A: Animation>(lhs: A, rhs: MediaTimingFunction) -> A {
    lhs.timingFunction = rhs
    return lhs
}

public func ~ <T>(lhs: KeyframeAnimation<T>, rhs: [MediaTimingFunction]) -> KeyframeAnimation<T> {
    lhs.timingFunctions = rhs
    return lhs
}
