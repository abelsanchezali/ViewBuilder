//
//  ReflectionHelperTests.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/21/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import ViewBuilder

public class TestClassForReflection {
}

@objc public enum TestEnumForReflection: Int {
    case case0
    case case1
    case case2
    case case3
}

extension TestEnumForReflection: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue)
    }
}

@objc public class TestClassForObjCKVO: NSObject {
    @objc public var intProperty: Int = 0
    @objc public var stringProperty: String = ""
    @objc public var enumProperty: TestEnumForReflection = .case0
    @objc public var instanceProperty: TestClassForObjCKVO? = nil
}

class ReflectionHelperTests: XCTestCase {

    func testFindBundleForPath() {
        #if os(iOS)
            let resource0 = "SampleFontTraitsView-iOS"
        #endif
        #if os(tvOS)
            let resource0 = "SampleFontTraitsView-tvOS"
        #endif
        guard let path0 = ConstantsHelper.Bundles.TestBundle.path(forResource: resource0, ofType: "xml") else {
            XCTFail("Not able to find path for \(resource0).xml document")
            return
        }
        XCTAssertEqual(ReflectionHelper.findBundleForPath(path0), ConstantsHelper.Bundles.TestBundle)
        guard let path1 = ConstantsHelper.Bundles.TestBundle.path(forResource: "SimpleView", ofType: "xml") else {
            XCTFail("Not able to find path for SimpleView.xml document")
            return
        }
        XCTAssertEqual(ReflectionHelper.findBundleForPath(path1), ConstantsHelper.Bundles.TestBundle)
        guard let path2 = ConstantsHelper.Bundles.TestBundle.path(forResource: "SampleResources", ofType: "xml") else {
            XCTFail("Not able to find path for SampleResources.xml document")
            return
        }
        XCTAssertEqual(ReflectionHelper.findBundleForPath(path2), ConstantsHelper.Bundles.TestBundle)
    }

    func testFindBundleWithModuleName() {
        XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("ViewBuilder"), ConstantsHelper.Bundles.ViewBuilderBundle)
        XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("UIKitCore"), ConstantsHelper.Bundles.UIKitBundle)
        XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("Foundation")?.bundleIdentifier?.hasSuffix(".Foundation"), true)
        XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("CoreFoundation")?.bundleIdentifier?.hasSuffix(".CoreFoundation"), true)
        XCTAssertNil(ReflectionHelper.findBundleWithModuleName("NotValid"))
    }

    func DISABLEDtestPerformanceFindBundleWithModuleName() {
        self.measure {
            for _ in 0..<5000 {
                XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("ViewBuilder"), ConstantsHelper.Bundles.ViewBuilderBundle)
                XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("UIKit"), ConstantsHelper.Bundles.UIKitBundle)
                XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("Foundation")?.bundleIdentifier?.hasSuffix(".Foundation"), true)
                XCTAssertEqual(ReflectionHelper.findBundleWithModuleName("CoreFoundation")?.bundleIdentifier?.hasSuffix(".CoreFoundation"), true)
            }
        }
    }

    func testClassWithName_Bundle() {
        // Testing Objective-C classes in different modules
        XCTAssert(ReflectionHelper.classWithName("UIView", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIView.Type)
        XCTAssert(ReflectionHelper.classWithName("UIButton", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIButton.Type)
        XCTAssert(ReflectionHelper.classWithName("NSMutableArray", bundle: ReflectionHelper.findBundleWithModuleName("CoreFoundation")) is NSMutableArray.Type)
        XCTAssert(ReflectionHelper.classWithName("NSData", bundle: ReflectionHelper.findBundleWithModuleName("CoreFoundation")) is NSData.Type)
        // Testing Swift classes in different modules
        XCTAssert(ReflectionHelper.classWithName("TestClassForReflection", bundle: ConstantsHelper.Bundles.TestBundle) is TestClassForReflection.Type)
        XCTAssert(ReflectionHelper.classWithName("DocumentBuilder", bundle: ConstantsHelper.Bundles.ViewBuilderBundle) is DocumentBuilder.Type)
    }

    // Used implementation classWithName is faster than classWithName_V2
    func DISABLEDtestPerformanceClassWithName_Bundle() {
        self.measure {
            for _ in 0..<5000 {
                XCTAssert(ReflectionHelper.classWithName("UIView", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIView.Type)
                XCTAssert(ReflectionHelper.classWithName("UIButton", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIButton.Type)
                XCTAssert(ReflectionHelper.classWithName("TestClassForReflection", bundle: ConstantsHelper.Bundles.TestBundle) is TestClassForReflection.Type)
                XCTAssert(ReflectionHelper.classWithName("DocumentBuilder", bundle: ConstantsHelper.Bundles.ViewBuilderBundle) is DocumentBuilder.Type)
            }
        }
    }

    func DISABLEDtestPerformanceClassWithName_V2_Bundle() {
        self.measure {
            for _ in 0..<5000 {
                XCTAssert(ReflectionHelper.classWithName_V2("UIView", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIView.Type)
                XCTAssert(ReflectionHelper.classWithName_V2("UIButton", bundle: ConstantsHelper.Bundles.UIKitBundle) is UIButton.Type)
                XCTAssert(ReflectionHelper.classWithName_V2("TestClassForReflection", bundle: ConstantsHelper.Bundles.TestBundle) is TestClassForReflection.Type)
                XCTAssert(ReflectionHelper.classWithName_V2("DocumentBuilder", bundle: ConstantsHelper.Bundles.ViewBuilderBundle) is DocumentBuilder.Type)
            }
        }
    }

    func testClassWithName_BundleIdentifier() {
        // Testing Objective-C classes in different modules
        XCTAssert(ReflectionHelper.classWithName("UIView", bundleIdentifier: ConstantsHelper.Bundles.UIKitBundleIdentifier) is UIView.Type)
        XCTAssert(ReflectionHelper.classWithName("UIButton", bundleIdentifier: ConstantsHelper.Bundles.UIKitBundleIdentifier) is UIButton.Type)
        XCTAssert(ReflectionHelper.classWithName("NSMutableArray", bundleIdentifier: ReflectionHelper.findBundleWithModuleName("CoreFoundation")?.bundleIdentifier!) is NSMutableArray.Type)
        XCTAssert(ReflectionHelper.classWithName("NSData", bundleIdentifier: ReflectionHelper.findBundleWithModuleName("CoreFoundation")?.bundleIdentifier) is NSData.Type)
        // Testing Swift classes in different modules
        XCTAssert(ReflectionHelper.classWithName("TestClassForReflection", bundleIdentifier: ConstantsHelper.Bundles.TestBundleIdentifier) is TestClassForReflection.Type)
        XCTAssert(ReflectionHelper.classWithName("DocumentBuilder", bundleIdentifier: ConstantsHelper.Bundles.ViewBuilderBundleIdentifier) is DocumentBuilder.Type)
    }

    func testGetAndSetPropertyWithName() {
        let instance0 = TestClassForObjCKVO()
        XCTAssertTrue(ReflectionHelper.setPropertyWithName("intProperty", value: 1, instance: instance0))
        XCTAssertEqual(instance0.intProperty, 1)
        XCTAssertEqual(1, ReflectionHelper.getPropertyWithName("intProperty", instance: instance0) as? Int)

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("intProperty", value: 100, instance: instance0))
        XCTAssertEqual(instance0.intProperty, 100)
        XCTAssertEqual(100, ReflectionHelper.getPropertyWithName("intProperty", instance: instance0) as? Int)

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("stringProperty", value: "HolaMundo", instance: instance0))
        XCTAssertEqual(instance0.stringProperty, "HolaMundo")
        XCTAssertEqual("HolaMundo", ReflectionHelper.getPropertyWithName("stringProperty", instance: instance0) as? String)

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("enumProperty", value: TestEnumForReflection.case1, instance: instance0))
        XCTAssertEqual(instance0.enumProperty, TestEnumForReflection.case1)
        XCTAssertEqual(TestEnumForReflection.case1.convertToNSValue(), ReflectionHelper.getPropertyWithName("enumProperty", instance: instance0) as? NSValue)

        let value = TestClassForObjCKVO()
        XCTAssertTrue(ReflectionHelper.setPropertyWithName("instanceProperty", value: value, instance: instance0))
        XCTAssertEqual(instance0.instanceProperty, value)
        XCTAssertEqual(value, ReflectionHelper.getPropertyWithName("instanceProperty", instance: instance0) as? TestClassForObjCKVO)

        let instance1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        XCTAssertTrue(ReflectionHelper.setPropertyWithName("backgroundColor", value: UIColor.blue, instance: instance1))
        XCTAssertEqual(instance1.backgroundColor, UIColor.blue)
        XCTAssertEqual(UIColor.blue, ReflectionHelper.getPropertyWithName("backgroundColor", instance: instance1) as? UIColor)

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("accessibilityIdentifier", value: "CONTROL_ID", instance: instance1))
        XCTAssertEqual(instance1.accessibilityIdentifier, "CONTROL_ID")
        XCTAssertEqual("CONTROL_ID", ReflectionHelper.getPropertyWithName("accessibilityIdentifier", instance: instance1) as? String)

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("accessibilityIdentifier", value: nil, instance: instance1))
        XCTAssertNil(instance1.accessibilityIdentifier)
        XCTAssertNil(ReflectionHelper.getPropertyWithName("accessibilityIdentifier", instance: instance1))

        XCTAssertTrue(ReflectionHelper.setPropertyWithName("borderWidth", value: 4.0, instance: instance1))
        XCTAssertEqual(instance1.borderWidth, 4.0)
        XCTAssertEqual(NSNumber(value: 4.0), ReflectionHelper.getPropertyWithName("borderWidth", instance: instance1) as? NSNumber)
    }

    func testSetPropertyWithPath() {
        let baseInstance = TestClassForObjCKVO()
        let instance0 = TestClassForObjCKVO()
        baseInstance.instanceProperty = instance0

        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("instanceProperty.intProperty", value: 1, instance: baseInstance))
        XCTAssertEqual(instance0.intProperty, 1)
        XCTAssertEqual(NSNumber(value: 1), ReflectionHelper.getPropertyWithPath("instanceProperty.intProperty", instance: baseInstance) as? NSNumber)

        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("instanceProperty.intProperty", value: 100, instance: baseInstance))
        XCTAssertEqual(instance0.intProperty, 100)
        XCTAssertEqual(NSNumber(value: 100), ReflectionHelper.getPropertyWithPath("instanceProperty.intProperty", instance: baseInstance) as? NSNumber)

        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("instanceProperty.stringProperty", value: "HolaMundo", instance: baseInstance))
        XCTAssertEqual(instance0.stringProperty, "HolaMundo")
        XCTAssertEqual("HolaMundo", ReflectionHelper.getPropertyWithPath("instanceProperty.stringProperty", instance: baseInstance) as? String)

        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("instanceProperty.enumProperty", value: TestEnumForReflection.case1, instance: baseInstance))
        XCTAssertEqual(instance0.enumProperty, TestEnumForReflection.case1)
        XCTAssertEqual(TestEnumForReflection.case1.convertToNSValue(), ReflectionHelper.getPropertyWithPath("instanceProperty.enumProperty", instance: baseInstance) as? NSNumber)

        let instance1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("layer.anchorPoint", value: CGPoint(x: 0.1, y: 0.2), instance: instance1))
        XCTAssertEqual(instance1.layer.anchorPoint, CGPoint(x: 0.1, y: 0.2))
        XCTAssertEqual(NSValue(cgPoint: CGPoint(x: 0.1, y: 0.2)), ReflectionHelper.getPropertyWithPath("layer.anchorPoint", instance: instance1) as? NSValue)

        XCTAssertTrue(ReflectionHelper.setPropertyWithPath("layer.borderWidth", value: 13, instance: instance1))
        XCTAssertEqual(instance1.layer.borderWidth, 13)
        XCTAssertEqual(NSNumber(value: 13), ReflectionHelper.getPropertyWithPath("layer.borderWidth", instance: instance1) as? NSValue)
    }
}
