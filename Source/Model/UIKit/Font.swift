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
  private static let TraitsByText: [String: UIFontDescriptor.SymbolicTraits] = ["Italic": UIFontDescriptor.SymbolicTraits.traitItalic,
                                                                               "Bold": UIFontDescriptor.SymbolicTraits.traitBold,
                                                                               "Expanded": UIFontDescriptor.SymbolicTraits.traitExpanded,
                                                                               "Condensed": UIFontDescriptor.SymbolicTraits.traitCondensed,
                                                                               "Monospace": UIFontDescriptor.SymbolicTraits.traitMonoSpace,
                                                                               "Vertical": UIFontDescriptor.SymbolicTraits.traitVertical,
                                                                               "Optimized": UIFontDescriptor.SymbolicTraits.traitUIOptimized,
                                                                               "Tight": UIFontDescriptor.SymbolicTraits.traitTightLeading,
                                                                               "Loose": UIFontDescriptor.SymbolicTraits.traitLooseLeading]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text,
              let words = service.parseValidWordsArray(from: value) else {
            return nil
        }
      var traits = UIFontDescriptor.SymbolicTraits()
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
  private static let StyleByText: [String: UIFont.TextStyle] = {
    var values = ["Headline": UIFont.TextStyle.headline,
                  "Subheadline": UIFont.TextStyle.subheadline,
                  "Body": UIFont.TextStyle.body,
                  "Footnote": UIFont.TextStyle.footnote,
                  "Caption1": UIFont.TextStyle.caption1,
                  "Caption2": UIFont.TextStyle.caption2]
        if #available(iOS 9.0, *) {
          values["Title1"] = UIFont.TextStyle.title1
          values["Title2"] = UIFont.TextStyle.title2
          values["Title3"] = UIFont.TextStyle.title3
          values["Callout"] = UIFont.TextStyle.callout
        }
        return values
    }()

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text?.trimmingCharacters(in: CharacterSet.whitespaces) else {
            return nil
        }
        return TextStyle.StyleByText[value]
    }
}

// UIFont

open class Font: Object, TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        // UIFont(descriptor: UIFontDescriptor, size: CGFloat)
        if let params = service.parseKeyValueSequence(from: value, params: ["name", "size", "traits"]) {
            guard let name = params[0] as? String,
                  let size = Double(value: params[1]),
                  let traits = params[2] as? UIFontDescriptor.SymbolicTraits ?? FontTraits.deserialize(text: params[2] as? String, service: service) as? UIFontDescriptor.SymbolicTraits else {
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
                return UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size), weight: UIFont.Weight(CGFloat(weight)))
            }
        }
        //UIFont.preferredFontForTextStyle(style: String)
        if let params = service.parseKeyValueSequence(from: value, params: ["style"]) {
          guard let style = params[0] as? UIFont.TextStyle ?? TextStyle.deserialize(text: params[0] as? String, service: service) as? UIFont.TextStyle else {
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
                return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight(CGFloat(weight)))
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
