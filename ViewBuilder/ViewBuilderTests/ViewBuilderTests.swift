//
//  ViewBuilderTests.swift
//  ViewBuilderTests
//
//  Created by Abel Sanchez on 6/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import XCTest
@testable import ViewBuilder

class ViewBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func DISABLEDtestExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func DISABLEDtestPerformance1() {
        let view = UIView()
        let keyPath = "layer.cornerRadius"
        let value = NSNumber(value: 5 as Double)
        self.measure {
            for _ in 0..<1000000 {
                view.setValue(value, forKeyPath: keyPath)
            }
        }
    }

    func DISABLEDtestPerformance2() {
        let view = UIView()
        let keyPath = "layer.cornerRadius"
        let value = NSNumber(value: 5 as Double)
        self.measure {
            for _ in 0..<1000000 {
                if keyPath.contains(".") {
                    view.setValue(value, forKeyPath: keyPath)
                } else {
                    view.setValue(value, forKey: keyPath)
                }
            }
        }
    }

    func DISABLEDtestPerformance3() {
        let view = UIView()
        let keyPath = "cornerRadius"
        let value = NSNumber(value: 5 as Double)
        self.measure {
            for _ in 0..<1000000 {
                view.setValue(value, forKey: keyPath)
            }
        }
    }

    func DISABLEDtestPerformance4() {
        let view = UIView()
        let keyPath = "cornerRadius"
        let value = NSNumber(value: 5 as Double)
        self.measure {
            for _ in 0..<1000000 {
                if !keyPath.contains(".") {
                    view.setValue(value, forKey: keyPath)
                }
            }
        }
    }
}
