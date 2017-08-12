//
//  ViewBuilderDemoTests.swift
//  ViewBuilderDemoTests
//
//  Created by Abel Sanchez on 6/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import XCTest
@testable import ViewBuilder
@testable import ViewBuilderDemo

class BaseDeserializerTests: XCTestCase {

    private func buildDefaultTextDeserializerServiceProtocolDelegate() -> TextDeserializerServiceProtocolDelegate {
        return DictionaryTextDeserializerServiceProtocolDelegate(values: ["a": 1,
                                                                          "pi": 3.14],
                                                                 domains: ["u": ConstantsHelper.Bundles.UIKitBundleIdentifier,
                                                                           "f": ConstantsHelper.Bundles.ViewBuilderBundleIdentifier,
                                                                           "t": ConstantsHelper.Bundles.TestBundleIdentifier])
    }

    func testLayoutAnchor() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(LayoutAnchor.bottom, Anchor.deserialize(text: "Bottom", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.center, Anchor.deserialize(text: "Center", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.centerX, Anchor.deserialize(text: "CenterX", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.centerY, Anchor.deserialize(text: "CenterY", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.fill, Anchor.deserialize(text: "Fill", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.left, Anchor.deserialize(text: "Left", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.right, Anchor.deserialize(text: "Right", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.top, Anchor.deserialize(text: "Top", service: service) as? LayoutAnchor)
        // Composed Anchor
        XCTAssertEqual(LayoutAnchor.fill, Anchor.deserialize(text: "Top,Left, Bottom,Right", service: service) as? LayoutAnchor)
        XCTAssertEqual(LayoutAnchor.center, Anchor.deserialize(text: "CenterX,CenterY", service: service) as? LayoutAnchor)
        XCTAssertEqual([LayoutAnchor.centerY, LayoutAnchor.bottom], Anchor.deserialize(text: "Bottom,CenterY", service: service) as? LayoutAnchor)
    }
    
    func testAxis() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        XCTAssertEqual(UILayoutConstraintAxis.horizontal, Axis.deserialize(text: "Horizontal", service: service) as? UILayoutConstraintAxis)
        XCTAssertEqual(UILayoutConstraintAxis.vertical, Axis.deserialize(text: "Vertical", service: service) as? UILayoutConstraintAxis)

    }

    func testConstrained() {
        let service = DefaultTextDeserializerService()
        let delegate = buildDefaultTextDeserializerServiceProtocolDelegate()
        service.delegate = delegate
        let constrained0 = Constrained.deserialize(text: "10,12", service: service) as? Constrained
        XCTAssert(constrained0?.conditions.count == 2)
        XCTAssert(constrained0?.conditions[0].value == 10)
        XCTAssert(constrained0?.conditions[1].value == 12)
        XCTAssert(constrained0?.conditions[0].relation == .equal)
        XCTAssert(constrained0?.conditions[1].relation == .equal)

        let constrained1 = Constrained.deserialize(text: "21+,7-", service: service) as? Constrained
        XCTAssert(constrained1?.conditions.count == 2)
        XCTAssert(constrained1?.conditions[0].value == 21)
        XCTAssert(constrained1?.conditions[1].value == 7)
        XCTAssert(constrained1?.conditions[0].relation == .greaterThanOrEqual)
        XCTAssert(constrained1?.conditions[1].relation == .lessThanOrEqual)

        let constrained2 = Constrained.deserialize(text: "1+,17-,8,3", service: service) as? Constrained
        XCTAssert(constrained2?.conditions.count == 4)
        XCTAssert(constrained2?.conditions[0].value == 1)
        XCTAssert(constrained2?.conditions[1].value == 17)
        XCTAssert(constrained2?.conditions[2].value == 8)
        XCTAssert(constrained2?.conditions[3].value == 3)
        XCTAssert(constrained2?.conditions[0].relation == .greaterThanOrEqual)
        XCTAssert(constrained2?.conditions[1].relation == .lessThanOrEqual)
        XCTAssert(constrained2?.conditions[2].relation == .equal)
        XCTAssert(constrained2?.conditions[3].relation == .equal)
    }
}
