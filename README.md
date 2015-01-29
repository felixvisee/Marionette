# Marionette

Concise and type safe `CALayer` animations!

## Example

The following example demonstrates how to move the given `layer` from `(50, 50)` to `(150, 150)` while changing its background color from red to blue:

```swift
animateLayer(layer, withDuration: 5, timingFunction: .EaseInEaseOut) { layer in
  layer.position ~= CGPointMake(50, 50) ... CGPointMake(150, 150)
  layer.backgroundColor ~= UIColor.redColor().CGColor ... UIColor.blueColor().CGColor
}
```

It's equivalent to:

```swift
let positionAnimation = CABasicAnimation(keyPath: "position")
positionAnimation.fromValue = NSValue(CGPoint: CGPointMake(50, 50))
positionAnimation.toValue = NSValue(CGPoint: CGPointMake(150, 150))

let backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
backgroundColorAnimation.fromValue = UIColor.redColor().CGColor
backgroundColorAnimation.toValue = UIColor.blueColor().CGColor

let animationGroup = CAAnimationGroup()
animationGroup.animations = [positionAnimation, backgroundColorAnimation]
animationGroup.duration = 5
animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

layer.addAnimation(animationGroup, forKey: nil)
```
