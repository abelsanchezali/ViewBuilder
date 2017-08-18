//
//  UIView.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/16/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: UIViewContentMode

extension UIViewContentMode: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class ContentMode: Object, TextDeserializer {
    private static let ViewContentModeByText: [String: UIViewContentMode] = ["ScaleToFill" : UIViewContentMode.scaleToFill,
                                                                             "ScaleAspectFit" : UIViewContentMode.scaleAspectFit,
                                                                             "ScaleAspectFill" : UIViewContentMode.scaleAspectFill,
                                                                             "Redraw" : UIViewContentMode.redraw,
                                                                             "Center" : UIViewContentMode.center,
                                                                             "Top" : UIViewContentMode.top,
                                                                             "Bottom" : UIViewContentMode.bottom,
                                                                             "Left" : UIViewContentMode.left,
                                                                             "Right" : UIViewContentMode.right,
                                                                             "TopLeft" : UIViewContentMode.topLeft,
                                                                             "TopRight" : UIViewContentMode.topRight,
                                                                             "BottomLeft" : UIViewContentMode.bottomLeft,
                                                                             "BottomRight" : UIViewContentMode.bottomRight]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return ContentMode.ViewContentModeByText[value]
    }
}
