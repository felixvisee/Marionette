//
//  PropertyAnimation.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class PropertyAnimation<T, U: CAPropertyAnimation>: Animation {
    public var additive: Bool = false
    public var cumulative: Bool = false
    public var valueFunction: ValueFunction? = nil

    internal func animationForProperty(property: Property<T>) -> U! {
        return nil
    }

    internal func populateAnimation(animation: U, forProperty property: Property<T>) {
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

public func ~= <T, U: CAPropertyAnimation>(lhs: Property<T>, rhs: PropertyAnimation<T, U>) -> U {
    let animation = rhs.animationForProperty(lhs)
    lhs.context.animations.append(animation)
    return animation
}
