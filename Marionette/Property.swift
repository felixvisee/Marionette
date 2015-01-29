//
//  Property.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import Foundation

public class Property<T> {
    internal let context: Context

    internal let layer: CALayer
    internal let keyPath: String!
    internal let pack: (T) -> AnyObject!

    public var value: T! {
        return layer.valueForKeyPath(keyPath) as? T
    }

    internal init(_ context: Context, _ layer: CALayer, _ keyPath: String!, _ pack: (T) -> AnyObject!) {
        self.context = context

        self.layer = layer
        self.keyPath = keyPath
        self.pack = pack
    }
}

// TODO: Choose operator
public func ~= <T>(lhs: Property<T>, rhs: PropertyAnimation<T>) {
    let animation = rhs.animationForProperty(lhs)
    lhs.context.animations.append(animation)
}
