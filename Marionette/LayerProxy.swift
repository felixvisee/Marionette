//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.

import UIKit

public class LayerProxy {
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
        bounds = Property(context, layer, "bounds", pack, unpack)
        position = Property(context, layer, "position", pack, unpack)
        zPosition = Property(context, layer, "zPosition", pack, unpack)
        anchorPoint = Property(context, layer, "anchorPoint", pack, unpack)
        anchorPointZ = Property(context, layer, "anchorPointZ", pack, unpack)
        transform = Property(context, layer, "transform", pack, unpack)
        hidden = Property(context, layer, "hidden", pack, unpack)
        doubleSided = Property(context, layer, "doubleSided", pack, unpack)
        sublayerTransform = Property(context, layer, "sublayerTransform", pack, unpack)
        masksToBounds = Property(context, layer, "masksToBounds", pack, unpack)
        contents = Property(context, layer, "contents", pack, unpack)
        contentsRect = Property(context, layer, "contentsRect", pack, unpack)
        contentsScale = Property(context, layer, "contentsScale", pack, unpack)
        contentsCenter = Property(context, layer, "contentsCenter", pack, unpack)
        minificationFilterBias = Property(context, layer, "minificationFilterBias", pack, unpack)
        backgroundColor = Property(context, layer, "backgroundColor", pack, unpack)
        cornerRadius = Property(context, layer, "cornerRadius", pack, unpack)
        borderWidth = Property(context, layer, "borderWidth", pack, unpack)
        borderColor = Property(context, layer, "borderColor", pack, unpack)
        opacity = Property(context, layer, "opacity", pack, unpack)
        composingFilter = Property(context, layer, "composingFilter", pack, unpack)
        filters = Property(context, layer, "filters", { $0.map(pack) }, { ($0 as! [AnyObject]).map(unpack) })
        backgroundFilters = Property(context, layer, "backgroundFilters", { $0.map(pack) }, { ($0 as! [AnyObject]).map(unpack) })
        shouldRasterize = Property(context, layer, "shouldRasterize", pack, unpack)
        rasterizationScale = Property(context, layer, "rasterizationScale", pack, unpack)
        shadowColor = Property(context, layer, "shadowColor", pack, unpack)
        shadowOpacity = Property(context, layer, "shadowOpacity", pack, unpack)
        shadowOffset = Property(context, layer, "shadowOffset", pack, unpack)
        shadowRadius = Property(context, layer, "shadowRadius", pack, unpack)
        shadowPath = Property(context, layer, "shadowPath", pack, unpack)
    }
}
