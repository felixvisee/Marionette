//
//  KeyframeAnimationTests.swift
//  Marionette
//
//  Created by Felix Jendrusch on 2/2/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import Quick
import Nimble

import Marionette

class KeyframeAnimationSpec: QuickSpec {
    override func spec() {
        describe("a timing function operator") {
            context("with an array operand") {
                context("and a single timing function") {
                    it("should create a keyframe animation with keyframes as well as a timing function") {
                        let animation: KeyframeAnimation<Int> = [(0, 0), (1, 1)] ~ .EaseInEaseOut
                        expect(animation.values).to(equal([0, 1]))
                        expect(animation.keyTimes).to(equal([0, 1]))
                        expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                    }
                }

                context("and multiple timing functions") {
                    it("should create a keyframe animation with keyframes as well as all timing functions") {
                        let animation: KeyframeAnimation<Float> = [(0, 0), (0.5, 0.5), (1, 1)] ~ [.EaseInEaseOut, .EaseInEaseOut]
                        expect(animation.values).to(equal([0, 0.5, 1]))
                        expect(animation.keyTimes).to(equal([0, 0.5, 1]))
                        expect(animation.timingFunctions).to(equal([MediaTimingFunction.EaseInEaseOut, MediaTimingFunction.EaseInEaseOut]))
                    }
                }
            }

            context("with a path operand") {
                context("and a single timing function") {
                    it("should create a keyframe animation with a path as well as a timing function") {
                        let path = CGPathCreateWithRect(CGRectMake(0, 0, 100, 100), nil)
                        let animation: KeyframeAnimation<CGPoint> = path ~ .EaseInEaseOut
                        expect(animation.path).to(beIdenticalTo(path))
                        expect(animation.timingFunction).to(equal(MediaTimingFunction.EaseInEaseOut))
                    }
                }

                context("and multiple timing functions") {
                    it("should create a keyframe animation with a path as well as all timing functions") {
                        let path = CGPathCreateWithRect(CGRectMake(0, 0, 100, 100), nil)
                        let animation: KeyframeAnimation<CGPoint> = path ~ [.EaseInEaseOut, .EaseInEaseOut]
                        expect(animation.path).to(beIdenticalTo(path))
                        expect(animation.timingFunctions).to(equal([MediaTimingFunction.EaseInEaseOut, MediaTimingFunction.EaseInEaseOut]))
                    }
                }
            }
        }

        describe("a property animation operator") {
            context("with an array operand") {
                it("should create a keyframe animation with keyframes") {
                    var animation: CAKeyframeAnimation!

                    animate(CALayer()) { layer in
                        animation = layer.opacity ~= [(0, 0), (0.5, 0.5), (1, 1)]
                    }

                    expect(animation.keyPath).to(equal("opacity"))
                    expect(animation.values as? [Float]).to(equal([0, 0.5, 1]))
                    expect(animation.keyTimes as? [Float]).to(equal([0, 0.5, 1]))
                }
            }

            context("with a path operand") {
                it("should create a keyframe animation with a path") {
                    let path = CGPathCreateWithRect(CGRectMake(0, 0, 100, 100), nil)
                    var animation: CAKeyframeAnimation!

                    animate(CALayer()) { layer in
                        animation = layer.position ~= path
                    }

                    expect(animation.keyPath).to(equal("position"))
                    expect(animation.path).to(beIdenticalTo(path))
                }
            }
        }
    }
}
