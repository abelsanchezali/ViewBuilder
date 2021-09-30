//
//  DefaultTextDeserializerService.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class DefaultTextDeserializerService: TextDeserializerServiceProtocol {

    public init() { }

    open weak var delegate: TextDeserializerServiceProtocolDelegate?

    private func resolveValueForKey(_ key: String) -> Any? {
        return delegate?.resolveValue(for: key)
    }

    private func resolveDomainForPrefix(_ prefix: String) -> String? {
        return delegate?.resolveDomain(for: prefix)
    }

    // MARK: - TextDeserializerServiceProtocol

    open func parseValidWordsArray(from text: String) -> [String]? {
        guard let values = ParsingHelper.parseValidWordsArray(text) else {
            return nil
        }
        var result = [String]()
        for text in values {
            guard let value = parseValue(from: text) else {
                return nil
            }
            result.append(String(describing: value))
        }
        return result
    }

    open func parseValidDoubleArray(from text: String) -> [Double]? {
        guard let values = ParsingHelper.parseValidWordsArray(text) else {
            return nil
        }
        var result = [Double]()
        for text in values {
            guard let value = parseValue(from: text), let item = Double(value: value) else {
                return nil
            }
            result.append(item)
        }
        return result
    }

    open func parseValidIntegerArray(from text: String) -> [Int]? {
        guard let values = ParsingHelper.parseValidWordsArray(text) else {
            return nil
        }
        var result = [Int]()
        for text in values {
            guard let value = parseValue(from: text), let item = Int(value: value) else {
                return nil
            }
            result.append(item)
        }
        return result
    }

    open func parseHexadecimalComponent(from text: String) -> [Int]? {
        return ParsingHelper.parseHexadecimalComponent(text)
    }

    open func parseKeyValueSequence(from text: String, params: [String]) -> [Any]? {
        guard let values = ParsingHelper.parseStandardKeyValueSequence(text, params: params) else {
            return nil
        }
        var result = [Any]()
        for text in values {
            guard let value = parseValue(from: text) else {
                return nil
            }
            result.append(value)
        }
        return result
    }

    open func parseValueSequence(from text: String) -> [Any]? {
        guard let values = ParsingHelper.parseValidWordsArray(text) else {
            return nil
        }
        var result = [Any]()
        for text in values {
            guard let value = parseValue(from: text) else {
                return nil
            }
            result.append(value)
        }
        return result
    }

    open func parseValue(from text: String) -> Any? {
        return getValueAndMutability(text).0
    }

    open func getValueAndMutability(_ text: String) -> (Any?, Bool) {
        var value: Any? = nil
        if text.hasPrefix("@") {
            let key = text.substring(from: text.index(text.startIndex, offsetBy: 1))
            value = resolveValueForKey(key)
            if let value = value {
                return (value, false)
            }
        }
        value = ParsingHelper.parseStringIntoBasicType(text)
        if let text = value as? String {
            let result = ParsingHelper.parseExpresion(text)
            switch result {
            case (_, .some, _):
                let prefix = result.0 ?? ""
                guard let domain = delegate?.resolveDomain(for: prefix) else {
                    Log.shared.write("Waring: Could not find domain for prefix = \"\(prefix)\" in expresion \"\(text)\".")
                    return (nil, false)
                }
                guard let typeName = result.1 else {
                    return (nil, false)
                }
                let parameter = result.2
                guard let typeClass = ReflectionHelper.classWithName(typeName, bundleIdentifier: domain) else {
                    Log.shared.write("Waring: Could not find Type \"\(domain).\(typeName)\".")
                    return (nil, false)
                }
                guard let deserializerClass = typeClass as? TextDeserializer.Type else {
                    Log.shared.write("Waring: \(domain).\(typeName) does not implement TextDeserializer protocol in expresion \"\(text)\".")
                    return (nil, false)
                }
                return (deserializerClass.deserialize(text: parameter, service: self), deserializerClass.isDeserializedInstanceMutable())
            default:
                return (text, false)
            }
        }
        return (value, false)
    }
}
