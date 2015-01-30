//
//  Utils.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/30/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import Foundation

internal func unzip<A, B>(x: [(A, B)]) -> ([A], [B]) {
    var ax = [A](), bx = [B]()
    for (a, b) in x {
        ax.append(a)
        bx.append(b)
    }
    return (ax, bx)
}
