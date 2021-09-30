//
//  DataDeserializerProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/2/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol DataDeserializerProtocol: DefaultConstructor {
    static var identifier: String { get }
    func loadData(from path: String, options: DocumentOptions) -> DataNode?
}
