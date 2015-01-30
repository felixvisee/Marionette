//
//  BasicAnimation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

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
