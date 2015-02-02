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

    public init(fromValue: T! = nil, toValue: T! = nil, byValue: T! = nil, duration aDuration: CFTimeInterval? = nil) {
        super.init()

        self.fromValue = fromValue
        self.toValue = toValue
        self.byValue = byValue

        if let duration = aDuration {
            self.duration = duration
        }
    }

    internal override func animationForProperty(property: Property<T>) -> CABasicAnimation! {
        var animation = CABasicAnimation()
        populateAnimation(animation, forProperty: property)
        return animation
    }

    internal func populateAnimation(animation: CABasicAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation, forProperty: property)

        animation.fromValue = map(self.fromValue, property.pack)
        animation.toValue = map(self.toValue, property.pack)
        animation.byValue = map(self.byValue, property.pack)
    }
}

public func ... <T>(lhs: T, rhs: T) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs, toValue: rhs)
}

prefix operator ... { }

prefix public func ... <T>(rhs: T) -> BasicAnimation<T> {
    return BasicAnimation(toValue: rhs)
}

postfix operator ... { }

postfix public func ... <T>(lhs: T) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs)
}

infix operator ~ { precedence 131 }

public func ~ <T>(lhs: Range<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs.startIndex, toValue: lhs.isEmpty ? lhs.endIndex : advance(lhs.startIndex, distance(lhs.startIndex, lhs.endIndex) - 1)) ~ rhs
}

public func ~ <T>(lhs: ClosedInterval<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: lhs.start, toValue: lhs.end) ~ rhs
}

public func ~ <T: ForwardIndexType>(lhs: HalfOpenInterval<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return Range(start: lhs.start, end: lhs.end) ~ rhs
}
