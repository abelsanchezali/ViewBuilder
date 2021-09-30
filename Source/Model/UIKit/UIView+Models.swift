//
//  UIView.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/16/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: UIViewContentMode

extension UIView.ContentMode: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class ContentMode: Object, TextDeserializer {
  private static let ViewContentModeByText: [String: UIView.ContentMode] = ["ScaleToFill" : UIView.ContentMode.scaleToFill,
                                                                           "ScaleAspectFit" : UIView.ContentMode.scaleAspectFit,
                                                                           "ScaleAspectFill" : UIView.ContentMode.scaleAspectFill,
                                                                           "Redraw" : UIView.ContentMode.redraw,
                                                                           "Center" : UIView.ContentMode.center,
                                                                           "Top" : UIView.ContentMode.top,
                                                                           "Bottom" : UIView.ContentMode.bottom,
                                                                           "Left" : UIView.ContentMode.left,
                                                                           "Right" : UIView.ContentMode.right,
                                                                           "TopLeft" : UIView.ContentMode.topLeft,
                                                                           "TopRight" : UIView.ContentMode.topRight,
                                                                           "BottomLeft" : UIView.ContentMode.bottomLeft,
                                                                           "BottomRight" : UIView.ContentMode.bottomRight]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return ContentMode.ViewContentModeByText[value]
    }
}
