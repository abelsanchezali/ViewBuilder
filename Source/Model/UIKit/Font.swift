//
//  Font.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import CoreText

// UIFontDescriptorSymbolicTraits

open class FontTraits: Object, TextDeserializer {
    private static let TraitsByText: [String: UIFontDescriptorSymbolicTraits] = ["Italic": UIFontDescriptorSymbolicTraits.traitItalic,
                                                                                 "Bold": UIFontDescriptorSymbolicTraits.traitBold,
                                                                                 "Expanded": UIFontDescriptorSymbolicTraits.traitExpanded,
                                                                                 "Condensed": UIFontDescriptorSymbolicTraits.traitCondensed,
                                                                                 "Monospace": UIFontDescriptorSymbolicTraits.traitMonoSpace,
                                                                                 "Vertical": UIFontDescriptorSymbolicTraits.traitVertical,
                                                                                 "Optimized": UIFontDescriptorSymbolicTraits.traitUIOptimized,
                                                                                 "Tight": UIFontDescriptorSymbolicTraits.traitTightLeading,
                                                                                 "Loose": UIFontDescriptorSymbolicTraits.traitLooseLeading]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text,
              let words = service.parseValidWordsArray(from: value) else {
            return nil
        }
        var traits = UIFontDescriptorSymbolicTraits()
        for w in words {
            if let t = FontTraits.TraitsByText[w] {
                traits.insert(t)
            }
        }
        return traits
    }
}

// UIFontTextStyle

open class TextStyle: Object, TextDeserializer {
    private static let StyleByText: [String: UIFontTextStyle] = {
        var values = ["Headline": UIFontTextStyle.headline,
                      "Subheadline": UIFontTextStyle.subheadline,
                      "Body": UIFontTextStyle.body,
                      "Footnote": UIFontTextStyle.footnote,
                      "Caption1": UIFontTextStyle.caption1,
                      "Caption2": UIFontTextStyle.caption2]
        if #available(iOS 9.0, *) {
            values["Title1"] = UIFontTextStyle.title1
            values["Title2"] = UIFontTextStyle.title2
            values["Title3"] = UIFontTextStyle.title3
            values["Callout"] = UIFontTextStyle.callout
        }
        return values
    }()

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text?.trimmingCharacters(in: CharacterSet.whitespaces) else {
            return nil
        }
        return TextStyle.StyleByText[value]
    }
}

// UIFont

open class Font: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        // UIFont(descriptor: UIFontDescriptor, size: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["name", "size", "traits"]) {
            guard let name = params[0] as? String,
                  let size = Double(value: params[1]),
                  let traits = params[2] as? UIFontDescriptorSymbolicTraits ?? FontTraits.deserialize(text: params[2] as? String, service: service) as? UIFontDescriptorSymbolicTraits else {
                return nil
            }
            guard let base = UIFont(name: name, size: CGFloat(size)) else {
                Log.shared.write("Warning: Not able to resolve font with name: \(name)")
                return nil
            }
            guard let descriptor = base.fontDescriptor.withSymbolicTraits(traits) else {
                Log.shared.write("Warning: Not able to resolve descriptor with traits: \(traits), for font \(base)")
                return nil
            }
            return UIFont(descriptor: descriptor, size: CGFloat(size))
        }
        // UIFont(name: String, size: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["name", "size"]) {
            guard let name = params[0] as? String,
                  let size = Double(value: params[1]) else {
                return nil
            }
            return UIFont(name: name.trimmingCharacters(in: CharacterSet.whitespaces), size: CGFloat(size))
        }
        //UIFont.boldSystemFontOfSize(fontSize: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["bold"]) {
            guard let size = Double(value: params[0]) else {
                return nil
            }
            return UIFont.boldSystemFont(ofSize: CGFloat(size))
        }
        //UIFont.italicSystemFontOfSize(fontSize: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["italic"]) {
            guard let size = Double(value: params[0]) else {
                return nil
            }
            return UIFont.italicSystemFont(ofSize: CGFloat(size))
        }
        //UIFont.monospacedDigitSystemFontOfSize(fontSize: CGFloat, weight: CGFloat)
        if #available(iOS 9.0, *) {
            if let params = service.parseKeyValueSequence(from: value, params: ["monospaced", "weight"]) {
                guard let size = Double(value: params[0]), let weight = Double(value: params[1]) else {
                    return nil
                }
                return UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size), weight: CGFloat(weight))
            }
        }
        //UIFont.preferredFontForTextStyle(style: String)
        if let params = service.parseKeyValueSequence(from: value, params: ["style"]) {
            guard let style = params[0] as? UIFontTextStyle ?? TextStyle.deserialize(text: params[0] as? String, service: service) as? UIFontTextStyle else {
                return nil
            }
            return UIFont.preferredFont(forTextStyle: style)
        }
        //UIFont.systemFontOfSize(fontSize: CGFloat, weight: CGFloat)
        if #available(iOS 8.2, *) {
            if let params = service.parseKeyValueSequence(from: value, params: ["system", "weight"]) {
                guard let size = Double(value: params[0]), let weight = Double(value: params[1]) else {
                        return nil
                }
                return UIFont.systemFont(ofSize: CGFloat(size), weight: CGFloat(weight))
            }
        }
        //UIFont.systemFontOfSize(fontSize: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["system"]) {
            guard let size = Double(value: params[0]) else {
                return nil
            }
            return UIFont.systemFont(ofSize: CGFloat(size))
        }
        return nil
    }
}

extension UIFont: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Font.deserialize(text: text, service: service)
    }
}
