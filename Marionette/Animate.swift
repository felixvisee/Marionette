//
//  Animate.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func animate(layer: CALayer, block: (LayerProxy) -> ()) {
    animate(layer, duration: nil, timingFunction: nil, key: nil, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval, block: (LayerProxy) -> ()) {
    animate(layer, duration: aDuration, timingFunction: nil, key: nil, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval, timingFunction aTimingFunction: MediaTimingFunction, block: (LayerProxy) -> ()) {
    animate(layer, duration: aDuration, timingFunction: aTimingFunction, key: nil, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval? = nil, timingFunction aTimingFunction: MediaTimingFunction? = nil, key: String? = nil, #block: (LayerProxy) -> ()) {
    let context = Context()

    block(LayerProxy(context, layer))

    if context.animations.count <= 1 && aDuration == nil && aTimingFunction == nil {
        let animation = context.animations.last
        layer.addAnimation(animation, forKey: key)
    } else {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = context.animations

        if let duration = aDuration {
            animationGroup.duration = duration
        }

        if let timingFunction = aTimingFunction {
            animationGroup.timingFunction = timingFunction.function()
        }

        layer.addAnimation(animationGroup, forKey: key)
    }
}
