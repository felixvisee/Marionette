//
//  BasicAnimationTests.swift
//  Marionette
//
//  Created by Felix Jendrusch on 2/2/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import Quick
import Nimble

import Marionette

class BasicAnimationSpec: QuickSpec {
    override func spec() {
        describe("a range operator") {
            context("with two operands") {
                it("should create a basic animation with from and to values") {
                    let animation: BasicAnimation<Int> = 0...1
                    expect(animation.fromValue).to(equal(0))
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                }
            }

            context("with a single right-hands side operand") {
                it("should create a basic animation with a to value") {
                    let animation: BasicAnimation<Int> = ...1
                    expect(animation.fromValue).to(beNil())
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                }
            }

            context("with a single left-hands side operand") {
                it("should create a basic animation with a from value") {
                    let animation: BasicAnimation<Int> = 0...
                    expect(animation.fromValue).to(equal(0))
                    expect(animation.toValue).to(beNil())
                    expect(animation.byValue).to(beNil())
                }
            }
        }

        describe("a timing function operator") {
            context("with a value operand") {
                it("should create a basic animation with a to values as well as a timing function") {
                    let animation: BasicAnimation<Int> = 1 ~ .EaseInEaseOut
                    expect(animation.fromValue).to(beNil())
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                    expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                }
            }

            context("with a range operand") {
                it("should create a basic animation with from and to values as well as a timing function") {
                    let animation: BasicAnimation<Int> = Range(start: 0, end: 2) ~ .EaseInEaseOut
                    expect(animation.fromValue).to(equal(0))
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                    expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                }
            }

            context("with a closed interval operand") {
                it("should create a basic animation with from and to values as well as a timing function") {
                    let animation: BasicAnimation<Int> = ClosedInterval(0, 1) ~ .EaseInEaseOut
                    expect(animation.fromValue).to(equal(0))
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                    expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                }
            }

            context("with a half open interval operand") {
                it("should create a basic animation with from and to values as well as a timing function") {
                    let animation: BasicAnimation<Int> = HalfOpenInterval(0, 2) ~ .EaseInEaseOut
                    expect(animation.fromValue).to(equal(0))
                    expect(animation.toValue).to(equal(1))
                    expect(animation.byValue).to(beNil())
                    expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                }
            }
        }

        describe("a property animation operator") {
            context("with a value operand") {
                it("should create a basic animation with a to value") {
                    var animation: CABasicAnimation!

                    animate(CALayer()) { layer in
                        animation = layer.opacity ~= 1
                    }

                    expect(animation.fromValue).to(beNil())
                    expect(animation.toValue as? Float).to(equal(1))
                    expect(animation.byValue).to(beNil())
                }
            }

            // Cannot test a property animation operator with a range operand
            // because no property conforms to protocol ForwardIndexType.
            xcontext("with a range operand") {}

            context("with a closed interval operand") {
                it("should create a basic animation with from and to values") {
                    var animation: CABasicAnimation!

                    animate(CALayer()) { layer in
                        animation = layer.opacity ~= ClosedInterval(0, 1)
                    }

                    expect(animation.fromValue as? Float).to(equal(0))
                    expect(animation.toValue as? Float).to(equal(1))
                    expect(animation.byValue).to(beNil())
                }
            }

            // Cannot test a property animation operator with a range operand
            // because no property conforms to protocol ForwardIndexType.
            xcontext("with a half open interval operand") {}
        }
    }
}
