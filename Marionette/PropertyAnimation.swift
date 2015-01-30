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

        if let valueFunction = self.valueFunction {
            animation.valueFunction = valueFunction.function()
        }
    }
}
