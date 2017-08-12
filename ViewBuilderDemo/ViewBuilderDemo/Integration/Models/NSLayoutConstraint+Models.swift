//
//  NSLayoutConstraint.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/3/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder

// MARK: - UILayoutConstraintAxis

extension UILayoutConstraintAxis: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

public class Axis: Object, TextDeserializer {
    private static let AxisByText: [String: UILayoutConstraintAxis] = ["Horizontal": UILayoutConstraintAxis.horizontal,
                                                                       "Vertical": UILayoutConstraintAxis.vertical]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return Axis.AxisByText[value]
    }
}


// MARK: - UIStackViewAlignment

@available(iOS 9.0, *)
extension UIStackViewAlignment: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

@available(iOS 9.0, *)
class StackViewAlignment: TextDeserializer {
    private static let StackViewAlignmentByText: [String: UIStackViewAlignment] = ["Fill": UIStackViewAlignment.fill,
                                                                                   "Leading": UIStackViewAlignment.leading,
                                                                                   "FirstBaseline": UIStackViewAlignment.firstBaseline,
                                                                                   "Center": UIStackViewAlignment.center,
                                                                                   "Trailing": UIStackViewAlignment.trailing,
                                                                                   "LastBaseline": UIStackViewAlignment.lastBaseline,
                                                                                   "Top": UIStackViewAlignment.top,
                                                                                   "Bottom": UIStackViewAlignment.bottom]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return StackViewAlignment.StackViewAlignmentByText[value]
    }
}

// MARK: - UIStackViewDistribution

@available(iOS 9.0, *)
extension UIStackViewDistribution: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

@available(iOS 9.0, *)
class StackViewDistribution: TextDeserializer {
    private static let StackViewDistributionByText: [String: UIStackViewDistribution] = ["EqualCentering": UIStackViewDistribution.equalCentering,
                                                                                         "EqualSpacing": UIStackViewDistribution.equalSpacing,
                                                                                         "Fill": UIStackViewDistribution.fill,
                                                                                         "FillEqually": UIStackViewDistribution.fillEqually,
                                                                                         "FillProportionally": UIStackViewDistribution.fillProportionally]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return StackViewDistribution.StackViewDistributionByText[value]
    }
}
