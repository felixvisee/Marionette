//
//  BasicAnimation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class BasicAnimation<T>: PropertyAnimation<T, CABasicAnimation> {
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

    internal override func populateAnimation(animation: CABasicAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation, forProperty: property)

        animation.fromValue = map(self.fromValue, property.pack)
        animation.toValue = map(self.toValue, property.pack)
        animation.byValue = map(self.byValue, property.pack)
    }
}

private func animation<T>(range: Range<T>) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: range.startIndex, toValue: range.isEmpty ? range.endIndex : advance(range.startIndex, distance(range.startIndex, range.endIndex) - 1))
}

private func animation<T>(interval: ClosedInterval<T>) -> BasicAnimation<T> {
    return BasicAnimation(fromValue: interval.start, toValue: interval.end)
}

private func animation<T: ForwardIndexType>(interval: HalfOpenInterval<T>) -> BasicAnimation<T> {
    return animation(Range(start: interval.start, end: interval.end))
}

infix operator ... {
    associativity none
    precedence 135
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

infix operator ~ {
    associativity none
    precedence 131
}

public func ~ <T>(lhs: T, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return ...lhs ~ rhs
}

public func ~ <T>(lhs: Range<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return animation(lhs) ~ rhs
}

public func ~ <T>(lhs: ClosedInterval<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return animation(lhs) ~ rhs
}

public func ~ <T: ForwardIndexType>(lhs: HalfOpenInterval<T>, rhs: MediaTimingFunction) -> BasicAnimation<T> {
    return animation(lhs) ~ rhs
}

infix operator ~= {
    associativity none
    precedence 130
}

public func ~= <T>(lhs: Property<T>, rhs: T) -> CABasicAnimation {
    return lhs ~= ...rhs
}

public func ~= <T>(lhs: Property<T>, rhs: Range<T>) -> CABasicAnimation {
    return lhs ~= animation(rhs)
}

public func ~= <T>(lhs: Property<T>, rhs: ClosedInterval<T>) -> CABasicAnimation {
    return lhs ~= animation(rhs)
}

public func ~= <T: ForwardIndexType>(lhs: Property<T>, rhs: HalfOpenInterval<T>) -> CABasicAnimation {
    return lhs ~= animation(rhs)
}
