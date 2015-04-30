//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.

import UIKit

public func animate(layer: CALayer, block: LayerProxy -> ()) {
    animate(layer, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval, block: LayerProxy -> ()) {
    animate(layer, duration: aDuration, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval, timingFunction aTimingFunction: MediaTimingFunction, block: LayerProxy -> ()) {
    animate(layer, duration: aDuration, timingFunction: aTimingFunction, block: block)
}

public func animate(layer: CALayer, duration aDuration: CFTimeInterval? = nil, timingFunction aTimingFunction: MediaTimingFunction? = nil, key: String? = nil, #block: LayerProxy -> ()) {
    let context = Context()

    block(LayerProxy(context, layer))

    if !context.animations.isEmpty {
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
