//
//  KeyframeAnimation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

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

public class KeyframeAnimation<T>: PropertyAnimation<T, CAKeyframeAnimation> {
    public var values: [T]? = nil
    public var path: CGPath? = nil
    public var keyTimes: [Float]? = nil
    public var timingFunctions: [MediaTimingFunction]? = nil
    public var calculationMode: CalculationMode = .Linear
    public var tensionValues: [Float]? = nil
    public var continuityValues: [Float]? = nil
    public var biasValues: [Float]? = nil
    public var rotationMode: RotationMode? = nil

    public override init() {}

    public init(keyFrames: [(Float, T)], duration aDuration: CFTimeInterval? = nil) {
        super.init()

        let (keyTimes, values) = unzip(keyFrames)

        self.values = values
        self.keyTimes = keyTimes

        if let duration = aDuration {
            self.duration = duration
        }
    }

    public init(path: CGPath, duration aDuration: CFTimeInterval? = nil) {
        super.init()

        self.path = path

        if let duration = aDuration {
            self.duration = duration
        }
    }

    internal override func animationForProperty(property: Property<T>) -> CAKeyframeAnimation! {
        var animation = CAKeyframeAnimation()
        populateAnimation(animation, forProperty: property)
        return animation
    }

    internal override func populateAnimation(animation: CAKeyframeAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation, forProperty: property)

        animation.values = values?.map(property.pack)
        animation.path = path
        animation.keyTimes = keyTimes
        animation.timingFunctions = timingFunctions?.map { $0.function() }
        animation.calculationMode = calculationMode.name
        animation.tensionValues = tensionValues
        animation.continuityValues = continuityValues
        animation.biasValues = biasValues
        animation.rotationMode = rotationMode?.name
    }
}

private func animation<T>(keyFrames: [(Float, T)]) -> KeyframeAnimation<T> {
    return KeyframeAnimation(keyFrames: keyFrames)
}

private func animation(path: CGPath) -> KeyframeAnimation<CGPoint> {
    return KeyframeAnimation(path: path)
}

infix operator ~ {
    associativity none
    precedence 131
}

public func ~ <T>(lhs: [(Float, T)], rhs: MediaTimingFunction) -> KeyframeAnimation<T> {
    return animation(lhs) ~ rhs
}

public func ~ (lhs: CGPath, rhs: MediaTimingFunction) -> KeyframeAnimation<CGPoint> {
    return animation(lhs) ~ rhs
}

public func ~ <T>(lhs: KeyframeAnimation<T>, rhs: [MediaTimingFunction]) -> KeyframeAnimation<T> {
    lhs.timingFunctions = rhs
    return lhs
}

public func ~ <T>(lhs: [(Float, T)], rhs: [MediaTimingFunction]) -> KeyframeAnimation<T> {
    return animation(lhs) ~ rhs
}

public func ~ (lhs: CGPath, rhs: [MediaTimingFunction]) -> KeyframeAnimation<CGPoint> {
    return animation(lhs) ~ rhs
}

infix operator ~= {
    associativity none
    precedence 130
}

public func ~= <T>(lhs: Property<T>, rhs: [(Float, T)]) -> CAKeyframeAnimation {
    return lhs ~= animation(rhs)
}

public func ~= (lhs: Property<CGPoint>, rhs: CGPath) -> CAKeyframeAnimation {
    return lhs ~= animation(rhs)
}
