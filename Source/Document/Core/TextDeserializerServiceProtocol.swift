//
//  TextDeserializerServiceProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol TextDeserializerServiceProtocolDelegate: KeyValueResolverProtocol {
    func resolveDomain(for prefix: String) -> String?
}

public protocol TextDeserializerServiceProtocol: AnyObject {
    var delegate: TextDeserializerServiceProtocolDelegate? { get set }

    func parseValidWordsArray(from text: String) -> [String]?
    func parseValidDoubleArray(from text: String) -> [Double]?
    func parseValidIntegerArray(from text: String) -> [Int]?

    func parseHexadecimalComponent(from text: String) -> [Int]?

    func parseKeyValueSequence(from text: String, params: [String]) -> [Any]?
    func parseValueSequence(from text: String) -> [Any]?

    func parseValue(from text: String) -> Any?
}
