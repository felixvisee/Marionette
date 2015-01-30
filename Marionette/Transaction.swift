//
//  Transaction.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/29/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public func transaction(block: () -> ()) {
    transactionWithDuration(nil, timingFunction: nil, block: block)
}

public func transactionWithDuration(aDuration: CFTimeInterval?, block: () -> ()) {
    transactionWithDuration(aDuration, timingFunction: nil, block: block)
}

public func transactionWithDuration(aDuration: CFTimeInterval?, timingFunction aTimingFunction: MediaTimingFunction? = nil, #block: () -> ()) {
    CATransaction.begin()

    if let duration = aDuration {
        CATransaction.setAnimationDuration(duration)
    }

    if let timingFunction = aTimingFunction {
        CATransaction.setAnimationTimingFunction(timingFunction.function())
    }

    block()

    CATransaction.commit()
}
