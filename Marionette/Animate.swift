//
//  Animate.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func animateLayer(layer: CALayer, block: (LayerProxy) -> ()) {
    animateLayer(layer, withDuration: nil, timingFunction: nil, forKey: nil, block: block)
}

public func animateLayer(layer: CALayer, withDuration aDuration: CFTimeInterval, block: (LayerProxy) -> ()) {
    animateLayer(layer, withDuration: aDuration, timingFunction: nil, forKey: nil, block: block)
}

public func animateLayer(layer: CALayer, withDuration aDuration: CFTimeInterval, timingFunction aTimingFunction: MediaTimingFunction, block: (LayerProxy) -> ()) {
    animateLayer(layer, withDuration: aDuration, timingFunction: aTimingFunction, forKey: nil, block: block)
}

public func animateLayer(layer: CALayer, withDuration aDuration: CFTimeInterval? = nil, timingFunction aTimingFunction: MediaTimingFunction? = nil, forKey key: String? = nil, #block: (LayerProxy) -> ()) {
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
