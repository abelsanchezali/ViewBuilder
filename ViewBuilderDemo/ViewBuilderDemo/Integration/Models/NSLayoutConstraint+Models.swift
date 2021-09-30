//
//  NSLayoutConstraint.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/3/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder
import UIKit

// MARK: - UILayoutConstraintAxis

extension NSLayoutConstraint.Axis: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

public class Axis: Object, TextDeserializer {
    private static let AxisByText: [String: NSLayoutConstraint.Axis] = ["Horizontal": NSLayoutConstraint.Axis.horizontal,
                                                                        "Vertical": NSLayoutConstraint.Axis.vertical]
    
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return Axis.AxisByText[value]
    }
}


// MARK: - UIStackViewAlignment

@available(iOS 9.0, *)
extension UIStackView.Alignment: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

@available(iOS 9.0, *)
class StackViewAlignment: TextDeserializer {
    private static let StackViewAlignmentByText: [String: UIStackView.Alignment] = ["Fill": UIStackView.Alignment.fill,
                                                                                    "Leading": UIStackView.Alignment.leading,
                                                                                    "FirstBaseline": UIStackView.Alignment.firstBaseline,
                                                                                    "Center": UIStackView.Alignment.center,
                                                                                    "Trailing": UIStackView.Alignment.trailing,
                                                                                    "LastBaseline": UIStackView.Alignment.lastBaseline,
                                                                                    "Top": UIStackView.Alignment.top,
                                                                                    "Bottom": UIStackView.Alignment.bottom]
    
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return StackViewAlignment.StackViewAlignmentByText[value]
    }
}

// MARK: - UIStackViewDistribution

@available(iOS 9.0, *)
extension UIStackView.Distribution: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

@available(iOS 9.0, *)
class StackViewDistribution: TextDeserializer {
    private static let StackViewDistributionByText: [String: UIStackView.Distribution] = ["EqualCentering": UIStackView.Distribution.equalCentering,
                                                                                          "EqualSpacing": UIStackView.Distribution.equalSpacing,
                                                                                          "Fill": UIStackView.Distribution.fill,
                                                                                          "FillEqually": UIStackView.Distribution.fillEqually,
                                                                                          "FillProportionally": UIStackView.Distribution.fillProportionally]
    
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return StackViewDistribution.StackViewDistributionByText[value]
    }
}
