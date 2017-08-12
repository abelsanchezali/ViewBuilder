//
//  DataDeserializer.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class DataDeserializer: NSObject, DataDeserializerProtocol {

    public required override init() {
        super.init()
    }

    open class var identifier: String { return "" }

    open func loadData(from path: String, options: DocumentOptions) -> DataNode? {
        return nil
    }
}
