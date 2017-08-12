//
//  BaseDeserializerTests.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/18/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import ViewBuilder

class BaseDeserializerTests: XCTestCase {

    private func buildDefaultTextDeserializerServiceProtocolDelegate() -> TextDeserializerServiceProtocolDelegate {
        return DictionaryTextDeserializerServiceProtocolDelegate(values: ["a": 1,
                                                                          "pi": 3.14],
                                                                 domains: ["u": ConstantsHelper.Bundles.UIKitBundleIdentifier,
                                                                           "f": ConstantsHelper.Bundles.ViewBuilderBundleIdentifier,
                                                                           "t": ConstantsHelper.Bundles.TestBundleIdentifier])
    }

    func testText() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual("Hello World", Text.deserialize(text: "Hello World", service: service) as? String)
        XCTAssertEqual("21", Text.deserialize(text: "21", service: service) as? String)
        XCTAssertEqual("true", Text.deserialize(text: "true", service: service) as? String)
        XCTAssertEqual("3.14", Text.deserialize(text: "3.14", service: service) as? String)
        XCTAssertEqual("@a", Text.deserialize(text: "@a", service: service) as? String)
    }

    func testBundle() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(ConstantsHelper.Bundles.UIKitBundle, ViewBuilder.Bundle.deserialize(text: "identifier: \(ConstantsHelper.Bundles.UIKitBundleIdentifier)", service: service) as? Foundation.Bundle)
        XCTAssertEqual(ConstantsHelper.Bundles.ViewBuilderBundle, ViewBuilder.Bundle.deserialize(text: "identifier: \(ConstantsHelper.Bundles.ViewBuilderBundleIdentifier)", service: service) as? Foundation.Bundle)
        XCTAssertEqual(ConstantsHelper.Bundles.ViewBuilderBundle, ViewBuilder.Bundle.deserialize(text: "path: \(ConstantsHelper.Bundles.ViewBuilderBundle.bundlePath)", service: service) as? Foundation.Bundle)
    }

    func testNSBundle() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(ConstantsHelper.Bundles.UIKitBundle, Foundation.Bundle.deserialize(text: "identifier: \(ConstantsHelper.Bundles.UIKitBundleIdentifier)", service: service) as? Foundation.Bundle)
        XCTAssertEqual(ConstantsHelper.Bundles.ViewBuilderBundle, Foundation.Bundle.deserialize(text: "identifier: \(ConstantsHelper.Bundles.ViewBuilderBundleIdentifier)", service: service) as? Foundation.Bundle)
        XCTAssertEqual(ConstantsHelper.Bundles.ViewBuilderBundle, Foundation.Bundle.deserialize(text: "path: \(ConstantsHelper.Bundles.ViewBuilderBundle.bundlePath)", service: service) as? Foundation.Bundle)
    }

    func testLayoutOrientation() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(LayoutOrientation.horizontal, Orientation.deserialize(text: "Horizontal", service: service) as? LayoutOrientation)
        XCTAssertEqual(LayoutOrientation.vertical, Orientation.deserialize(text: "Vertical", service: service) as? LayoutOrientation)
    }

    func testLayoutAlignment() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(LayoutAlignment.center, Alignment.deserialize(text: "Center", service: service) as? LayoutAlignment)
        XCTAssertEqual(LayoutAlignment.maximum, Alignment.deserialize(text: "Maximum", service: service) as? LayoutAlignment)
        XCTAssertEqual(LayoutAlignment.minimum, Alignment.deserialize(text: "Minimum", service: service) as? LayoutAlignment)
        XCTAssertEqual(LayoutAlignment.stretch, Alignment.deserialize(text: "Stretch", service: service) as? LayoutAlignment)
    }

    func testPathFromBundle() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        let pathExpected = ConstantsHelper.Bundles.TestBundle.path(forResource: "SimpleView", ofType: "xml")
        // Test with explicit identifier
        let pathWithIdentifier = PathFromBundle.deserialize(text: "path:SimpleView.xml, identifier:\(ConstantsHelper.Bundles.TestBundleIdentifier)", service: service) as? String
        XCTAssertEqual(pathExpected, pathWithIdentifier)
        // Test with domain prefix identifier
        let pathWithDomain = PathFromBundle.deserialize(text: "path:SimpleView.xml, identifier: @domains.t", service: service) as? String
        XCTAssertEqual(pathExpected, pathWithDomain)
    }

    func testMutable() {
        XCTAssertTrue(Mutable.isDeserializedInstanceMutable())
    }

    func testContentMode() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(UIViewContentMode.bottom, ContentMode.deserialize(text: "Bottom", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.bottomLeft, ContentMode.deserialize(text: "BottomLeft", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.bottomRight, ContentMode.deserialize(text: "BottomRight", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.center, ContentMode.deserialize(text: "Center", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.left, ContentMode.deserialize(text: "Left", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.redraw, ContentMode.deserialize(text: "Redraw", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.right, ContentMode.deserialize(text: "Right", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.scaleAspectFill, ContentMode.deserialize(text: "ScaleAspectFill", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.scaleAspectFit, ContentMode.deserialize(text: "ScaleAspectFit", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.scaleToFill, ContentMode.deserialize(text: "ScaleToFill", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.top, ContentMode.deserialize(text: "Top", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.topLeft, ContentMode.deserialize(text: "TopLeft", service: service) as? UIViewContentMode)
        XCTAssertEqual(UIViewContentMode.topRight, ContentMode.deserialize(text: "TopRight", service: service) as? UIViewContentMode)
    }

    func testControlState() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(UIControlState.normal, ControlState.deserialize(text: "Normal", service: service) as? UIControlState)
        XCTAssertEqual(UIControlState.highlighted, ControlState.deserialize(text: "Highlighted", service: service) as? UIControlState)
        XCTAssertEqual(UIControlState.disabled, ControlState.deserialize(text: "Disabled", service: service) as? UIControlState)
        XCTAssertEqual(UIControlState.selected, ControlState.deserialize(text: "Selected", service: service) as? UIControlState)
        XCTAssertEqual(UIControlState.application, ControlState.deserialize(text: "Application", service: service) as? UIControlState)
        XCTAssertEqual(UIControlState.reserved, ControlState.deserialize(text: "Reserved", service: service) as? UIControlState)
        if #available(iOS 9.0, *) {
            XCTAssertEqual(UIControlState.focused, ControlState.deserialize(text: "Focused", service: service) as? UIControlState)
        }
    }

    func testStringForState() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Default usage
        let state0 = StringForState.deserialize(text: "HolaMundo", service: service) as? StringForState
        XCTAssertEqual("HolaMundo", state0?.value)
        XCTAssertEqual(UIControlState.normal, state0?.state)
        // Using with literal string
        let state1 = StringForState.deserialize(text: "f:Text(f:Text())", service: service) as? StringForState
        XCTAssertEqual("f:Text()", state1?.value)
        XCTAssertEqual(UIControlState.normal, state1?.state)
        // Using with number string
        let state2 = StringForState.deserialize(text: "13", service: service) as? StringForState
        XCTAssertEqual("13", state2?.value)
        XCTAssertEqual(UIControlState.normal, state2?.state)
        // Testing unsing state parameter
        let state3 = StringForState.deserialize(text: "value: HolaMundo, state: f:ControlState(Normal)", service: service) as? StringForState
        XCTAssertEqual("HolaMundo", state3?.value)
        XCTAssertEqual(UIControlState.normal, state3?.state)
        // Using with literal string with state parameter
        let state4 = StringForState.deserialize(text: "value: f:Text(f:Text()), state: f:ControlState(Selected)", service: service) as? StringForState
        XCTAssertEqual("f:Text()", state4?.value)
        XCTAssertEqual(UIControlState.selected, state4?.state)
        // Using with number string with state parameter
        let state5 = StringForState.deserialize(text: "value: 13, state: f:ControlState(Disabled)", service: service) as? StringForState
        XCTAssertEqual("13", state5?.value)
        XCTAssertEqual(UIControlState.disabled, state5?.state)
    }

    func testColor() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing Colors by name
        XCTAssertEqual(UIColor.black, Color.deserialize(text: "Black", service: service) as? UIColor)
        XCTAssertEqual(UIColor.blue, Color.deserialize(text: "Blue", service: service) as? UIColor)
        XCTAssertEqual(UIColor.brown, Color.deserialize(text: "Brown", service: service) as? UIColor)
        XCTAssertEqual(UIColor.clear, Color.deserialize(text: "Clear", service: service) as? UIColor)
        XCTAssertEqual(UIColor.cyan, Color.deserialize(text: "Cyan", service: service) as? UIColor)
        XCTAssertEqual(UIColor.darkGray, Color.deserialize(text: "DarkGray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.darkText, Color.deserialize(text: "DarkText", service: service) as? UIColor)
        XCTAssertEqual(UIColor.gray, Color.deserialize(text: "Gray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.green, Color.deserialize(text: "Green", service: service) as? UIColor)
        XCTAssertEqual(UIColor.lightGray, Color.deserialize(text: "LightGray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.lightText, Color.deserialize(text: "LightText", service: service) as? UIColor)
        XCTAssertEqual(UIColor.magenta, Color.deserialize(text: "Magenta", service: service) as? UIColor)
        XCTAssertEqual(UIColor.orange, Color.deserialize(text: "Orange", service: service) as? UIColor)
        XCTAssertEqual(UIColor.purple, Color.deserialize(text: "Purple", service: service) as? UIColor)
        XCTAssertEqual(UIColor.white, Color.deserialize(text: "White", service: service) as? UIColor)
        XCTAssertEqual(UIColor.yellow, Color.deserialize(text: "Yellow", service: service) as? UIColor)
        // Ignoring ColorSpace
        // Testing colors with hexadecimal components
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: 1.0),
                                                 Color.deserialize(text: "#AABBCC", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: CGFloat(33.0 / 255.0)),
                                                 Color.deserialize(text: "#AABBCC21", service: service) as? UIColor))
        // Testing using integer components 
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                        green: CGFloat(187.0 / 255.0),
                                                        blue: CGFloat(204.0 / 255.0),
                                                        alpha: 1.0),
                                                 Color.deserialize(text: "170,187,204", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: CGFloat(33.0 / 255.0)),
                                                 Color.deserialize(text: "170,187,204,33", service: service) as? UIColor))
        // Testing using double components
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: 0.666667,
                                                         green: 0.733333,
                                                         blue: 0.8,
                                                         alpha: 1.0),
                                                 Color.deserialize(text: "0.666667,0.733333,0.8,1", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: 0.666667,
                                                         green: 0.733333,
                                                         blue: 0.8,
                                                         alpha: 0.2222),
                                                 Color.deserialize(text: "0.666667,0.733333,0.8,0.222", service: service) as? UIColor))
    }

    func testUIColor() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing Colors by name
        XCTAssertEqual(UIColor.black, Color.deserialize(text: "Black", service: service) as? UIColor)
        XCTAssertEqual(UIColor.blue, Color.deserialize(text: "Blue", service: service) as? UIColor)
        XCTAssertEqual(UIColor.brown, Color.deserialize(text: "Brown", service: service) as? UIColor)
        XCTAssertEqual(UIColor.clear, Color.deserialize(text: "Clear", service: service) as? UIColor)
        XCTAssertEqual(UIColor.cyan, Color.deserialize(text: "Cyan", service: service) as? UIColor)
        XCTAssertEqual(UIColor.darkGray, Color.deserialize(text: "DarkGray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.darkText, Color.deserialize(text: "DarkText", service: service) as? UIColor)
        XCTAssertEqual(UIColor.gray, Color.deserialize(text: "Gray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.green, Color.deserialize(text: "Green", service: service) as? UIColor)
        XCTAssertEqual(UIColor.lightGray, Color.deserialize(text: "LightGray", service: service) as? UIColor)
        XCTAssertEqual(UIColor.lightText, Color.deserialize(text: "LightText", service: service) as? UIColor)
        XCTAssertEqual(UIColor.magenta, Color.deserialize(text: "Magenta", service: service) as? UIColor)
        XCTAssertEqual(UIColor.orange, Color.deserialize(text: "Orange", service: service) as? UIColor)
        XCTAssertEqual(UIColor.purple, Color.deserialize(text: "Purple", service: service) as? UIColor)
        XCTAssertEqual(UIColor.white, Color.deserialize(text: "White", service: service) as? UIColor)
        XCTAssertEqual(UIColor.yellow, Color.deserialize(text: "Yellow", service: service) as? UIColor)
        // Ignoring ColorSpace
        // Testing colors with hexadecimal components
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: 1.0),
                                                 UIColor.deserialize(text: "#AABBCC", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: CGFloat(33.0 / 255.0)),
                                                 UIColor.deserialize(text: "#AABBCC21", service: service) as? UIColor))
        // Testing using integer components
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: 1.0),
                                                 UIColor.deserialize(text: "170,187,204", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: CGFloat(170.0 / 255.0),
                                                         green: CGFloat(187.0 / 255.0),
                                                         blue: CGFloat(204.0 / 255.0),
                                                         alpha: CGFloat(33.0 / 255.0)),
                                                 UIColor.deserialize(text: "170,187,204,33", service: service) as? UIColor))
        // Testing using double components
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: 0.666667,
                                                         green: 0.733333,
                                                         blue: 0.8,
                                                         alpha: 1.0),
                                                 UIColor.deserialize(text: "0.666667,0.733333,0.8,1", service: service) as? UIColor))
        XCTAssertTrue(ComparatorHelper.areEquals(UIColor(red: 0.666667,
                                                         green: 0.733333,
                                                         blue: 0.8,
                                                         alpha: 0.2222),
                                                 UIColor.deserialize(text: "0.666667,0.733333,0.8,0.222", service: service) as? UIColor))
    }

    func testColorForState() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        let state0 = ColorForState.deserialize(text: "f:Color(Red)", service: service) as? ColorForState
        XCTAssertEqual(state0?.state, UIControlState.normal)
        XCTAssertEqual(state0?.value, UIColor.red)
        let state1 = ColorForState.deserialize(text: "value: f:Color(Red), state: f:ControlState(Disabled)", service: service) as? ColorForState
        XCTAssertEqual(state1?.state, UIControlState.disabled)
        XCTAssertEqual(state1?.value, UIColor.red)
    }

    func testButtonType() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(UIButtonType.contactAdd, ButtonType.deserialize(text: "ContactAdd", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.custom, ButtonType.deserialize(text: "Custom", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.detailDisclosure, ButtonType.deserialize(text: "DetailDisclosure", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.infoLight, ButtonType.deserialize(text: "InfoLight", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.infoDark, ButtonType.deserialize(text: "InfoDark", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.roundedRect, ButtonType.deserialize(text: "RoundedRect", service: service) as? UIButtonType)
        XCTAssertEqual(UIButtonType.system, ButtonType.deserialize(text: "System", service: service) as? UIButtonType)

    }

    func testTextAlignment() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(NSTextAlignment.center, TextAlignment.deserialize(text: "Center", service: service) as? NSTextAlignment)
        XCTAssertEqual(NSTextAlignment.justified, TextAlignment.deserialize(text: "Justified", service: service) as? NSTextAlignment)
        XCTAssertEqual(NSTextAlignment.left, TextAlignment.deserialize(text: "Left", service: service) as? NSTextAlignment)
        XCTAssertEqual(NSTextAlignment.natural, TextAlignment.deserialize(text: "Natural", service: service) as? NSTextAlignment)
        XCTAssertEqual(NSTextAlignment.right, TextAlignment.deserialize(text: "Right", service: service) as? NSTextAlignment)
    }

    func testRect() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(CGRect(origin: CGPoint(x: 2, y: 3), size: CGSize(width: 4, height: 5)),
                       Rect.deserialize(text: "2,3,4,5", service: service) as? CGRect)
        XCTAssertEqual(CGRect(origin: CGPoint(x: 2.4, y: 3.6), size: CGSize(width: 4.8, height: 5.0)),
                       Rect.deserialize(text: "2.4,3.6,4.8,5.0", service: service) as? CGRect)
    }

    func testPoint() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(CGPoint(x: 2, y: 3),
                       Point.deserialize(text: "2,3", service: service) as? CGPoint)
        XCTAssertEqual(CGPoint(x: 3.14, y: 1.81),
                       Point.deserialize(text: "3.14,1.81", service: service) as? CGPoint)
    }

    func testSize() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(CGSize(width: 2, height: 3),
                       Size.deserialize(text: "2,3", service: service) as? CGSize)
        XCTAssertEqual(CGSize(width: 3.14, height: 1.81),
                       Size.deserialize(text: "3.14,1.81", service: service) as? CGSize)
    }

    func testEdgeInsets() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(UIEdgeInsetsMake(8, 8, 8, 8),
                       EdgeInsets.deserialize(text: "8", service: service) as? UIEdgeInsets)
        XCTAssertEqual(UIEdgeInsetsMake(8, 2.0, 8, 2.0),
                       EdgeInsets.deserialize(text: "8, 2.0", service: service) as? UIEdgeInsets)
        XCTAssertEqual(UIEdgeInsetsMake(1.0, 2.0, 3, 4.0),
                       EdgeInsets.deserialize(text: "1.0, 2.0, 3, 4.0", service: service) as? UIEdgeInsets)
    }

    func testFontTraits() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Simple
        XCTAssertEqual(FontTraits.deserialize(text: "Italic", service: service) as? UIFontDescriptorSymbolicTraits, .traitItalic)
        XCTAssertEqual(FontTraits.deserialize(text: "Bold", service: service) as? UIFontDescriptorSymbolicTraits, .traitBold)
        XCTAssertEqual(FontTraits.deserialize(text: "Expanded", service: service) as? UIFontDescriptorSymbolicTraits, .traitExpanded)
        XCTAssertEqual(FontTraits.deserialize(text: "Condensed", service: service) as? UIFontDescriptorSymbolicTraits, .traitCondensed)
        XCTAssertEqual(FontTraits.deserialize(text: "Monospace", service: service) as? UIFontDescriptorSymbolicTraits, .traitMonoSpace)
        XCTAssertEqual(FontTraits.deserialize(text: "Vertical", service: service) as? UIFontDescriptorSymbolicTraits, .traitVertical)
        XCTAssertEqual(FontTraits.deserialize(text: "Optimized", service: service) as? UIFontDescriptorSymbolicTraits, .traitUIOptimized)
        XCTAssertEqual(FontTraits.deserialize(text: "Tight", service: service) as? UIFontDescriptorSymbolicTraits, .traitTightLeading)
        XCTAssertEqual(FontTraits.deserialize(text: "Loose", service: service) as? UIFontDescriptorSymbolicTraits, .traitLooseLeading)
        // Compound
        XCTAssertEqual(FontTraits.deserialize(text: "Italic, Bold,Expanded", service: service) as? UIFontDescriptorSymbolicTraits,
                       [.traitItalic, .traitBold, .traitExpanded])
    }

    func testTextStyle() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(TextStyle.deserialize(text: "Headline", service: service) as? UIFontTextStyle, UIFontTextStyle.headline)
        XCTAssertEqual(TextStyle.deserialize(text: "Subheadline", service: service) as? UIFontTextStyle, UIFontTextStyle.subheadline)
        XCTAssertEqual(TextStyle.deserialize(text: "Body", service: service) as? UIFontTextStyle, UIFontTextStyle.body)
        XCTAssertEqual(TextStyle.deserialize(text: "Footnote", service: service) as? UIFontTextStyle, UIFontTextStyle.footnote)
        XCTAssertEqual(TextStyle.deserialize(text: "Caption1", service: service) as? UIFontTextStyle, UIFontTextStyle.caption1)
        XCTAssertEqual(TextStyle.deserialize(text: "Caption2", service: service) as? UIFontTextStyle, UIFontTextStyle.caption2)
        if #available(iOS 9.0, *) {
            XCTAssertEqual(TextStyle.deserialize(text: "Title1", service: service) as? UIFontTextStyle, UIFontTextStyle.title1)
            XCTAssertEqual(TextStyle.deserialize(text: "Title2", service: service) as? UIFontTextStyle, UIFontTextStyle.title2)
            XCTAssertEqual(TextStyle.deserialize(text: "Title3", service: service) as? UIFontTextStyle, UIFontTextStyle.title3)
            XCTAssertEqual(TextStyle.deserialize(text: "Callout", service: service) as? UIFontTextStyle, UIFontTextStyle.callout)
        }
    }

    func testFont() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing format "familiy", "size", "traits"
        guard let font0 = Font.deserialize(text: "name: Helvetica Neue, size:20, traits: Bold", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font0, traits: .boldTrait))
        XCTAssertEqual(20.0, font0.pointSize)
        XCTAssertEqual("Helvetica Neue", font0.familyName)

        guard let font1 = Font.deserialize(text: "name: Helvetica Neue, size:48, traits: f:FontTraits(Italic)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font1, traits: .italicTrait))
        XCTAssertEqual(48.0, font1.pointSize)
        XCTAssertEqual("Helvetica Neue", font1.familyName)

        guard let font2 = Font.deserialize(text: "name: Helvetica Neue, size:32, traits:f:FontTraits(Italic,Bold)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font2, traits: [.italicTrait, .boldTrait]))
        XCTAssertEqual(32.0, font2.pointSize)
        XCTAssertEqual("Helvetica Neue", font2.familyName)
        // Testing format "name", "size"
        guard let font3 = Font.deserialize(text: "name: Zapfino, size:16", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(16.0, font3.pointSize)
        XCTAssertEqual("Zapfino", font3.familyName)
        // Testing format "bold"
        guard let font4 = Font.deserialize(text: "bold: 20", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(20.0, font4.pointSize)
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font4, traits: .boldTrait))
        // Testing format "italic"
        guard let font5 = Font.deserialize(text: "italic: 30.0", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(30.0, font5.pointSize)
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font5, traits: .italicTrait))
        // Testing format "monospaced", "weight"
        if #available(iOS 9.0, *) {
            guard let font6 = Font.deserialize(text: "monospaced: 16, weight: 12", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.monospacedDigitSystemFont(ofSize: 16, weight: 12), font6)
        }
        // Testing format "style"
        if #available(iOS 9.0, *) {
            guard let font7 = Font.deserialize(text: "style: Title1", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.preferredFont(forTextStyle: .title1), font7)
        }
        guard let font8 = Font.deserialize(text: "style: f:TextStyle(Headline)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(UIFont.preferredFont(forTextStyle: .headline), font8)
        // Testing format "system", "weight"
        if #available(iOS 8.2, *) {
            guard let font10 = Font.deserialize(text: "system: 16, weight:21", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.systemFont(ofSize: 16, weight: 21.0), font10)
        }
        // Testing format "system"
        if #available(iOS 8.2, *) {
            guard let font11 = Font.deserialize(text: "system: 23", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.systemFont(ofSize: 23), font11)
        }
    }

    func testUIFont() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing format "familiy", "size", "traits"
        guard let font0 = UIFont.deserialize(text: "name: Helvetica Neue, size:20, traits: Bold", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font0, traits: .boldTrait))
        XCTAssertEqual(20.0, font0.pointSize)
        XCTAssertEqual("Helvetica Neue", font0.familyName)

        guard let font1 = UIFont.deserialize(text: "name: Helvetica Neue, size:48, traits: f:FontTraits(Italic)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font1, traits: .italicTrait))
        XCTAssertEqual(48.0, font1.pointSize)
        XCTAssertEqual("Helvetica Neue", font1.familyName)

        guard let font2 = UIFont.deserialize(text: "name: Helvetica Neue, size:32, traits:f:FontTraits(Italic,Bold)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font2, traits: [.italicTrait, .boldTrait]))
        XCTAssertEqual(32.0, font2.pointSize)
        XCTAssertEqual("Helvetica Neue", font2.familyName)
        // Testing format "name", "size"
        guard let font3 = UIFont.deserialize(text: "name: Zapfino, size:16", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(16.0, font3.pointSize)
        XCTAssertEqual("Zapfino", font3.familyName)
        // Testing format "bold"
        guard let font4 = UIFont.deserialize(text: "bold: 20", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(20.0, font4.pointSize)
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font4, traits: .boldTrait))
        // Testing format "italic"
        guard let font5 = UIFont.deserialize(text: "italic: 30.0", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(30.0, font5.pointSize)
        XCTAssertTrue(ComparatorHelper.hasTrait(font: font5, traits: .italicTrait))
        // Testing format "monospaced", "weight"
        if #available(iOS 9.0, *) {
            guard let font6 = UIFont.deserialize(text: "monospaced: 16, weight: 12", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.monospacedDigitSystemFont(ofSize: 16, weight: 12), font6)
        }
        // Testing format "style"
        if #available(iOS 9.0, *) {
            guard let font7 = UIFont.deserialize(text: "style: Title1", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.preferredFont(forTextStyle: .title1), font7)
        }
        guard let font8 = UIFont.deserialize(text: "style: f:TextStyle(Headline)", service: service) as? UIFont else {
            XCTFail("Font not decoded")
            return
        }
        XCTAssertEqual(UIFont.preferredFont(forTextStyle: .headline), font8)
        // Testing format "system", "weight"
        if #available(iOS 8.2, *) {
            guard let font10 = UIFont.deserialize(text: "system: 16, weight:21", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.systemFont(ofSize: 16, weight: 21.0), font10)
        }
        // Testing format "system"
        if #available(iOS 8.2, *) {
            guard let font11 = UIFont.deserialize(text: "system: 23", service: service) as? UIFont else {
                XCTFail("Font not decoded")
                return
            }
            XCTAssertEqual(UIFont.systemFont(ofSize: 23), font11)
        }
    }

    func testNib() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing format "name", "bundle"
        guard let nib0 = Nib.deserialize(text: "name: sampleView, bundle: f:Bundle(\(ConstantsHelper.Bundles.TestBundleIdentifier))",
            service: service) as? Nib else {
            XCTFail("Nib not decoded")
            return
        }
        XCTAssertEqual(nib0.bundle, ConstantsHelper.Bundles.TestBundle)
        XCTAssertEqual(nib0.name, "sampleView")

        // Testing format "name", "identifier"
        guard let nib1 = Nib.deserialize(text: "name: sampleView, identifier: \(ConstantsHelper.Bundles.TestBundleIdentifier)",
            service: service) as? Nib else {
            XCTFail("Nib not decoded")
            return
        }
        XCTAssertEqual(nib1.bundle, ConstantsHelper.Bundles.TestBundle)
        XCTAssertEqual(nib1.name, "sampleView")
    }

    func testImage() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing format "named", "bundle"
        guard (Image.deserialize(text: "named: IconApp, bundle: f:Bundle(\(ConstantsHelper.Bundles.TestBundleIdentifier))",
            service: service) as? UIImage) != nil else {
            XCTFail("Image not decoded")
            return
        }
        let path = ConstantsHelper.Bundles.TestBundle.path(forResource: "IconApp", ofType: "png")!
        guard (Image.deserialize(text: "path: \(path)", service: service) as? UIImage) != nil else {
            XCTFail("Image not decoded")
            return
        }
        // Not Testing format "named" or default because we can't add resurces to bundle running tests
    }

    func testUIImage() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // Testing format "named", "bundle"
        guard (UIImage.deserialize(text: "named: IconApp, bundle: f:Bundle(\(ConstantsHelper.Bundles.TestBundleIdentifier))",
            service: service) as? UIImage) != nil else {
            XCTFail("Image not decoded")
            return
        }
        let path = ConstantsHelper.Bundles.TestBundle.path(forResource: "IconApp", ofType: "png")!
        guard (UIImage.deserialize(text: "path: \(path)", service: service) as? UIImage) != nil else {
            XCTFail("Image not decoded")
            return
        }
        // Not Testing format "named" or default because we can't add resurces to bundle running tests
    }

    func testFillRule() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(FillRule.deserialize(text: "non-zero", service: service) as? String, "non-zero")
        XCTAssertEqual(FillRule.deserialize(text: "even-odd", service: service) as? String, "even-odd")
        XCTAssertEqual(FillRule.deserialize(text: "NonZero", service: service) as? String, "non-zero")
        XCTAssertEqual(FillRule.deserialize(text: "EvenOdd", service: service) as? String, "even-odd")
    }

    func testOrientation() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(Orientation.deserialize(text: "Vertical", service: service) as? LayoutOrientation, .vertical)
        XCTAssertEqual(Orientation.deserialize(text: "Horizontal", service: service) as? LayoutOrientation, .horizontal)
    }

    func testAlignment() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(Alignment.deserialize(text: "Center", service: service) as? LayoutAlignment, LayoutAlignment.center)
        XCTAssertEqual(Alignment.deserialize(text: "Maximum", service: service) as? LayoutAlignment, LayoutAlignment.maximum)
        XCTAssertEqual(Alignment.deserialize(text: "Minimum", service: service) as? LayoutAlignment, LayoutAlignment.minimum)
        XCTAssertEqual(Alignment.deserialize(text: "Stretch", service: service) as? LayoutAlignment, LayoutAlignment.stretch)
    }

    func testLocalized() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        // TODO:
        // Testing format "key", "tableName", "bundle", "value", "comment"
        // Testing format "key", "bundle", "tableName"
        // Testing format "key"

        // Testing format "key", "bundle"
        XCTAssertEqual(Localized.deserialize(text: "key: Hello_World, bundle: f:Bundle(@domains.t)", service: service) as? String, "Hello World")
    }

    func testPath() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertNotNil(Path.deserialize(text: "data: M8,19 L5,19 L5,8 L8,8 L8,19 L8,19 Z M6.5,6.732 C5.534,6.732 4.75,5.942 4.75,4.968 C4.75,3.994 5.534,3.204 6.5,3.204 C7.466,3.204 8.25,3.994 8.25,4.968 C8.25,5.942 7.467,6.732 6.5,6.732 L6.5,6.732 Z M20,19 L17,19 L17,13.396 C17,10.028 13,10.283 13,13.396 L13,19 L10,19 L10,8 L13,8 L13,9.765 C14.396,7.179 20,6.988 20,12.241 L20,19 L20,19 Z", service: service))
    }
}
