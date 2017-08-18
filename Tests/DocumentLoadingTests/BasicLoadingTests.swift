//
//  BasicLoadingTests.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/20/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import ViewBuilder

class BasicLoadingTests: XCTestCase {

#if os(iOS)
    func testSampleFontTraitsView() {
        guard let documentPath = ConstantsHelper.Bundles.TestBundle.path(forResource: "SampleFontTraitsView-iOS", ofType: "xml") else {
            XCTFail("Not able to find path for SampleFontTraitsView-iOS.xml document")
            return
        }
        guard let scrollView: UIScrollView = DocumentBuilder.shared.load(documentPath) else {
            XCTFail("Not able to load SampleFontTraitsView-iOS.xml document")
            return
        }
        XCTAssertEqual(scrollView.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
        XCTAssertEqual(scrollView.contentSize, CGSize(width: 300, height: 900))
        XCTAssertEqual(scrollView.subviews.count, 1)

        let contentView = scrollView.subviews[0]
        XCTAssertEqual(contentView.frame, CGRect(x: 0, y: 0, width: 300, height: 900))
        XCTAssertEqual(contentView.subviews.count, 15)

        let labels = contentView.subviews.flatMap { $0 as? UILabel }
        XCTAssertEqual(labels.count, 15)

        // Validate Text
        XCTAssertEqual(labels[ 0].text, "Bold Bold Bold")
        XCTAssertEqual(labels[ 1].text, "Condensed-Bold")
        XCTAssertEqual(labels[ 2].text, "MonoSpace MonoSpace MonoSpace")
        XCTAssertEqual(labels[ 3].text, "Vertical Vertical Vertical")
        XCTAssertEqual(labels[ 4].text, "Italic Bold Italic Bold")
        XCTAssertEqual(labels[ 5].text, "Tight Tight Tight")
        XCTAssertEqual(labels[ 6].text, "Loose Loose Loose")
        XCTAssertEqual(labels[ 7].text, "HelveticaNeue-UltraLight")
        XCTAssertEqual(labels[ 8].text, "GurmukhiMN-Bold")
        XCTAssertEqual(labels[ 9].text, "GillSans-BoldItalic")
        XCTAssertEqual(labels[10].text, "MarkerFelt-Wide")
        XCTAssertEqual(labels[11].text, "CourierNewPSMT")
        XCTAssertEqual(labels[12].text, "Zapfino")
        XCTAssertEqual(labels[13].text, "Futura-CondensedExtraBold")
        XCTAssertEqual(labels[14].text, "Bodoni Ornaments")

        // Validate Frame
        var frame = CGRect(x: 0, y: 0, width: 300, height: 45)
        for index in 0..<15 {
            XCTAssertEqual(labels[index].frame, frame, "Label[\(index)] frame don't match")
            frame.origin.y += 50
        }

        // Validate Background Color
        for index in 0..<15 {
            XCTAssertEqual(labels[index].backgroundColor, UIColor.gray, "Label[\(index)] backgroundColor don't match")
        }

        // Validate Text Color
        for index in 0..<15 {
            XCTAssertEqual(labels[index].textColor, UIColor.green, "Label[\(index)] textColor don't match")
        }

        // Validate Font Size
        for index in 0..<15 {
            XCTAssertEqual(labels[index].font.pointSize, 20, "Label[\(index)] font.pointSize don't match")
        }
    }
#endif

#if os(tvOS)
    func testSampleFontTraitsView() {
        guard let documentPath = ConstantsHelper.Bundles.TestBundle.path(forResource: "SampleFontTraitsView-tvOS", ofType: "xml") else {
            XCTFail("Not able to find path for SampleFontTraitsView-tvOS.xml document")
            return
        }
        guard let scrollView: UIScrollView = DocumentBuilder.shared.load(documentPath) else {
            XCTFail("Not able to load SampleFontTraitsView-tvOS.xml document")
            return
        }
        XCTAssertEqual(scrollView.bounds, CGRect(x: 0, y: 0, width: 300, height: 300))
        XCTAssertEqual(scrollView.contentSize, CGSize(width: 300, height: 900))
        XCTAssertEqual(scrollView.subviews.count, 1)

        let contentView = scrollView.subviews[0]
        XCTAssertEqual(contentView.frame, CGRect(x: 0, y: 0, width: 300, height: 900))
        XCTAssertEqual(contentView.subviews.count, 12)

        let labels = contentView.subviews.flatMap { $0 as? UILabel }
        XCTAssertEqual(labels.count, 12)

        // Validate Text
        XCTAssertEqual(labels[ 0].text, "Bold Bold Bold")
        XCTAssertEqual(labels[ 1].text, "Condensed-Bold")
        XCTAssertEqual(labels[ 2].text, "MonoSpace MonoSpace MonoSpace")
        XCTAssertEqual(labels[ 3].text, "Vertical Vertical Vertical")
        XCTAssertEqual(labels[ 4].text, "Italic Bold Italic Bold")
        XCTAssertEqual(labels[ 5].text, "Optimized Optimized Optimized")
        XCTAssertEqual(labels[ 6].text, "Tight Tight Tight")
        XCTAssertEqual(labels[ 7].text, "Loose Loose Loose")
        XCTAssertEqual(labels[ 8].text, "HelveticaNeue-UltraLight")
        XCTAssertEqual(labels[ 9].text, "GurmukhiMN-Bold")
        XCTAssertEqual(labels[10].text, "CourierNewPSMT")
        XCTAssertEqual(labels[11].text, "Futura-CondensedExtraBold")

        // Validate Frame
        var frame = CGRect(x: 0, y: 0, width: 300, height: 45)
        for index in 0..<12 {
            XCTAssertEqual(labels[index].frame, frame, "Label[\(index)] frame don't match")
            frame.origin.y += 50
        }

        // Validate Background Color
        for index in 0..<12 {
            XCTAssertEqual(labels[index].backgroundColor, UIColor.gray, "Label[\(index)] backgroundColor don't match")
        }

        // Validate Text Color
        for index in 0..<12 {
            XCTAssertEqual(labels[index].textColor, UIColor.green, "Label[\(index)] textColor don't match")
        }
        
        // Validate Font Size
        for index in 0..<12 {
            XCTAssertEqual(labels[index].font.pointSize, 20, "Label[\(index)] font.pointSize don't match")
        }
    }
#endif

    func testSampleResources() {
        guard let documentPath = ConstantsHelper.Bundles.TestBundle.path(forResource: "SampleResources", ofType: "xml") else {
            XCTFail("Not able to find path for SampleResources.xml document")
            return
        }
        guard let resources: Resources = DocumentBuilder.shared.load(documentPath) else {
            XCTFail("Not able to load SampleResources.xml document")
            return
        }
        guard (resources["font1"] as? UIFont) != nil else {
            XCTFail("Not able to get font1 item")
            return
        }
        guard (resources["font2"] as? UIFont) != nil else {
            XCTFail("Not able to get font2 item")
            return
        }
        guard (resources["font3"] as? UIFont) != nil else {
            XCTFail("Not able to get font3 item")
            return
        }
        guard let summary = resources["summary"] as? String else {
            XCTFail("Not able to get summary item")
            return
        }
        XCTAssertEqual(summary, "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.")

        guard let insight = resources["insight"] as? String else {
            XCTFail("Not able to get insight item")
            return
        }
        XCTAssertEqual(insight, "It is a fact that a reader will be distracted by the readable content when looking its layout.")

        guard (resources["cellStyle"] as? ObjectStyle) != nil else {
            XCTFail("Not able to get cellStyle item")
            return
        }
        guard (resources["buttonStyle"] as? ObjectStyle) != nil else {
            XCTFail("Not able to get insight item")
            return
        }
    }

    func testSampleCellWithLayoutView() {
        guard let documentPath = ConstantsHelper.Bundles.TestBundle.path(forResource: "SampleCellWithLayoutView", ofType: "xml") else {
            XCTFail("Not able to find path for SampleCellWithLayoutView.xml document")
            return
        }
        guard let container: StackPanel = DocumentBuilder.shared.load(documentPath) else {
            XCTFail("Not able to load SampleCellWithLayoutView.xml document")
            return
        }

        XCTAssertEqual(container.subviews.count, 4)
        XCTAssertEqual(container.orientation, .vertical)

        // Validate document references
        guard let references = container.documentReferences else {
            XCTFail("References not provided")
            return
        }

        // Validate references
        guard let imageView = references["imageView"] as? UIView else {
            XCTFail("Reference with name imageView not provided")
            return
        }
        XCTAssertEqual(imageView.preferredSize, CGSize(width: 50, height: 50))
        XCTAssertEqual(imageView.cornerRadius, 2)
        XCTAssertEqual(imageView.backgroundColor, UIColor.orange)
        XCTAssertEqual(imageView.margin, UIEdgeInsetsMake(0, 0, 0, 8))

        guard let summaryLabel = references["summaryLabel"] as? UILabel else {
            XCTFail("Reference with name summaryLabel not provided")
            return
        }
        XCTAssertEqual(summaryLabel.numberOfLines, 0)

        guard let insightLabel = references["insightLabel"] as? UILabel else {
            XCTFail("Reference with name insightLabel not provided")
            return
        }
        XCTAssertEqual(insightLabel.horizontalAlignment, .stretch)
        XCTAssertEqual(insightLabel.numberOfLines, 0)

        guard let button = references["button"] as? UIButton else {
            XCTFail("Reference with name button not provided")
            return
        }
        XCTAssertEqual(button.buttonType, .custom)
        XCTAssertEqual(button.margin, UIEdgeInsetsMake(4, 60, 0, 0))
        XCTAssertEqual(button.title(for: .normal), "Say thanks")

        container.frame = CGRect(origin: CGPoint.zero, size: container.sizeThatFits(CGSize(width: 300, height: 10000)))
        container.layoutSubviews()
        // TODO: Validate Layout
    }

}
