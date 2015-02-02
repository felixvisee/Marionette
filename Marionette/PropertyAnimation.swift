//
//  PropertyAnimation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class PropertyAnimation<T>: Animation {
    public var additive: Bool = false
    public var cumulative: Bool = false
    public var valueFunction: ValueFunction? = nil

    internal func animationForProperty(property: Property<T>) -> CAPropertyAnimation! {
        return nil
    }

    internal func populateAnimation(animation: CAPropertyAnimation, forProperty property: Property<T>) {
        super.populateAnimation(animation)

        animation.keyPath = property.keyPath
        animation.additive = additive
        animation.cumulative = cumulative
        animation.valueFunction = self.valueFunction?.function()
    }
}

infix operator ~= {
    associativity none
    precedence 130
}

public func ~= <T>(lhs: Property<T>, rhs: PropertyAnimation<T>) {
    let animation = rhs.animationForProperty(lhs)
    lhs.context.animations.append(animation)
}
