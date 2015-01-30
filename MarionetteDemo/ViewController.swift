//
//  ViewController.swift
//  MarionetteDemo
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit
import Marionette

class ViewController: UIViewController {
    var box: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        box = UIView(frame: CGRectMake(0, 0, 100, 100))
        box.backgroundColor = UIColor.redColor()

        view.addSubview(box)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        animate(box.layer, duration: 5, timingFunction: .EaseInEaseOut) { layer in
            layer.position ~= CGPointMake(50, 50) ... CGPointMake(150, 150)
            layer.position.value = CGPointMake(150, 150)

            layer.backgroundColor ~= UIColor.redColor().CGColor ... UIColor.blueColor().CGColor
            layer.backgroundColor.value = UIColor.blueColor().CGColor

            layer.opacity ~= [(0.0, 0.0), (0.5, 0.5), (1.0, 0.0)]
            layer.opacity.value = 0
        }
    }
}
