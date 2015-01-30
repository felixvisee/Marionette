//
//  LayerProxy.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/28/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public class LayerProxy {
    internal let context: Context

    public let bounds: Property<CGRect>
    public let position: Property<CGPoint>
    public let zPosition: Property<CGFloat>
    public let anchorPoint: Property<CGPoint>
    public let anchorPointZ: Property<CGFloat>
    public let transform: Property<CATransform3D>
    public let hidden: Property<Bool>
    public let doubleSided: Property<Bool>
    public let sublayerTransform: Property<CATransform3D>
    public let masksToBounds: Property<Bool>
    public let contents: Property<CIImage>
    public let contentsRect: Property<CGRect>
    public let contentsScale: Property<CGFloat>
    public let contentsCenter: Property<CGRect>
    public let minificationFilterBias: Property<Float>
    public let backgroundColor: Property<CGColor>
    public let cornerRadius: Property<CGFloat>
    public let borderWidth: Property<CGFloat>
    public let borderColor: Property<CGColor>
    public let opacity: Property<Float>
    public let composingFilter: Property<CIFilter>
    public let filters: Property<[CIFilter]>
    public let backgroundFilters: Property<[CIFilter]>
    public let shouldRasterize: Property<Bool>
    public let rasterizationScale: Property<CGFloat>
    public let shadowColor: Property<CGColor>
    public let shadowOpacity: Property<Float>
    public let shadowOffset: Property<CGSize>
    public let shadowRadius: Property<CGFloat>
    public let shadowPath: Property<CGPath>

    internal init(_ context: Context, _ layer: CALayer) {
        self.context = context

        bounds = Property(context, layer, "bounds", { NSValue(CGRect: $0) })
        position = Property(context, layer, "position", { NSValue(CGPoint: $0) })
        zPosition = Property(context, layer, "zPosition", { $0 })
        anchorPoint = Property(context, layer, "anchorPoint", { NSValue(CGPoint: $0) })
        anchorPointZ = Property(context, layer, "anchorPointZ", { $0 })
        transform = Property(context, layer, "transform", { NSValue(CATransform3D: $0) })
        hidden = Property(context, layer, "hidden", { $0 })
        doubleSided = Property(context, layer, "doubleSided", { $0 })
        sublayerTransform = Property(context, layer, "sublayerTransform", { NSValue(CATransform3D: $0) })
        masksToBounds = Property(context, layer, "masksToBounds", { $0 })
        contents = Property(context, layer, "contents", { $0 })
        contentsRect = Property(context, layer, "contentsRect", { NSValue(CGRect: $0) })
        contentsScale = Property(context, layer, "contentsScale", { $0 })
        contentsCenter = Property(context, layer, "contentsCenter", { NSValue(CGRect: $0) })
        minificationFilterBias = Property(context, layer, "minificationFilterBias", { $0 })
        backgroundColor = Property(context, layer, "backgroundColor", { $0 })
        cornerRadius = Property(context, layer, "cornerRadius", { $0 })
        borderWidth = Property(context, layer, "borderWidth", { $0 })
        borderColor = Property(context, layer, "borderColor", { $0 })
        opacity = Property(context, layer, "opacity", { $0 })
        composingFilter = Property(context, layer, "composingFilter", { $0 })
        filters = Property(context, layer, "filters", { $0 })
        backgroundFilters = Property(context, layer, "backgroundFilters", { $0 })
        shouldRasterize = Property(context, layer, "shouldRasterize", { $0 })
        rasterizationScale = Property(context, layer, "rasterizationScale", { $0 })
        shadowColor = Property(context, layer, "shadowColor", { $0 })
        shadowOpacity = Property(context, layer, "shadowOpacity", { $0 })
        shadowOffset = Property(context, layer, "shadowOffset", { NSValue(CGSize: $0) })
        shadowRadius = Property(context, layer, "shadowRadius", { $0 })
        shadowPath = Property(context, layer, "shadowPath", { $0 })
    }
}
