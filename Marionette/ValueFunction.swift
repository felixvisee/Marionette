//
//  ValueFunction.swift
//  Marionette
//
//  Created by Felix Jendrusch on 1/29/15.
//  Copyright (c) 2015 Felix Jendrusch. All rights reserved.
//

import UIKit

public enum ValueFunction {
    case RotateX
    case RotateY
    case RotateZ
    case Scale
    case ScaleX
    case ScaleY
    case ScaleZ
    case Translate
    case TranslateX
    case TranslateY
    case TranslateZ

    public var name: String {
        switch self {
        case .RotateX:
            return kCAValueFunctionRotateX
        case .RotateY:
            return kCAValueFunctionRotateY
        case .RotateZ:
            return kCAValueFunctionRotateZ
        case .Scale:
            return kCAValueFunctionScale
        case .ScaleX:
            return kCAValueFunctionScaleX
        case .ScaleY:
            return kCAValueFunctionScaleY
        case .ScaleZ:
            return kCAValueFunctionScaleZ
        case .Translate:
            return kCAValueFunctionTranslate
        case .TranslateX:
            return kCAValueFunctionTranslateX
        case .TranslateY:
            return kCAValueFunctionTranslateY
        case .TranslateZ:
            return kCAValueFunctionTranslateZ
        }
    }

    public func function() -> CAValueFunction {
        return CAValueFunction(name: name)
    }
}
