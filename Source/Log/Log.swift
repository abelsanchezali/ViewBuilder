//
//  Log.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Log: NSObject {
    public static let shared = Log()

    open func write(_ text: String, file: String = #file, function: String = #function, line: Int = #line) {
        print("ViewBuilder - [\((file as NSString).lastPathComponent) \(function) line:\(line)]: \(text)")
    }
}
