//
//  StringHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public extension String {
    func substring(_ range: NSRange) -> String? {
        if range.location == NSNotFound {
            return nil
        }
        let startRange = self.index(self.startIndex, offsetBy: range.location)
        let endRange = self.index(startRange, offsetBy: range.length)
        return self.substring(with: startRange..<endRange)
    }
}

public class ParsingHelper {
    
    public class func parseValidWordsArray(_ text: String) -> [String]? {
        let z = text.split(separator: ",", maxSplits: Int.max, omittingEmptySubsequences: false).map { String($0).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
        let index = z.firstIndex { $0.isEmpty }
        if let _ = index {
            return nil
        }
        return z
    }
    
    public class func parseValidDoubleArray(_ text: String) -> [Double]? {
        let z = text.split(separator: ",", maxSplits: Int.max, omittingEmptySubsequences: false).map { Double(String($0).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) }
        let index = z.firstIndex { $0 == nil }
        if let _ = index {
            return nil
        } else {
            return z.compactMap { $0 }
        }
    }
    
    public class func parseValidIntegerArray(_ text: String) -> [Int]? {
        let z = text.split(separator: ",", maxSplits: Int.max, omittingEmptySubsequences: false).map { Int(String($0).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) }
        let index = z.firstIndex { $0 == nil }
        if let _ = index {
            return nil
        } else {
            return z.compactMap { $0 }
        }
    }
    
    static var hexadecimalComponentExpresion: NSRegularExpression? = { try! NSRegularExpression(pattern: "^\\s*#([0-9A-F]+)\\s*$", options: [.caseInsensitive]) }()
    
    public class func parseHexadecimalComponent(_ text: String) -> [Int]? {
        guard let match = ParsingHelper.hexadecimalComponentExpresion?.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                                                  range: NSMakeRange(0, text.count)) else {
            return nil
        }
        let range = match.range(at:1)
        var result = [Int]()
        var take = range.length % 2 == 0 ? 2 : 1
        var index = 0
        repeat {
            if let str = text.substring(NSRange(location: index + range.location, length: take)), let byte = Int(str, radix: 16) {
                result.append(byte)
            } else {
                return nil
            }
            index += take
            take = 2
        } while index < range.length
        return result
    }
    
    public class func parseStandardKeyValueSequence(_ text: String, params: [String]) -> [String]? {
        let text = text.trimmingCharacters(in: CharacterSet.whitespaces)
        // Build pattern like this one: ^name:\s*(.+),+\s*size:\s*(.+)$
        var values = [String]()
        var pattern = params.reduce("^") { $0 + $1 + ":\\s*(.+),+\\s*" }
        pattern = pattern.substring(to: pattern.index(pattern.endIndex, offsetBy: -5)) + "$"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            guard let match = regex.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count)) else {
                return nil
            }
            for index in stride(from: 1, to: params.count + 1, by: 1) {
                let range = match.range(at:index)
                guard let substr = text.substring(range) else {
                    return nil
                }
                values.append(substr)
            }
            return values
        } catch {
            return nil
        }
    }
    
    public class func parseStringIntoBasicType(_ text: String) -> Any? {
        switch text {
        case "YES", "true":
            return true
        case "NO", "false":
            return false
        case "nil":
            return NSNull()
        default:
            if let int = Int(text) {
                return int
            } else if let double = Double(text) {
                return double
            }
        }
        return text
    }
    
    static var attributedExpresion: NSRegularExpression? = { try! NSRegularExpression(pattern: "^([a-zA-Z_]\\w*):?([a-zA-Z_]\\w*)?\\((.*)\\)$", options: .anchorsMatchLines) }()
    
    public class func parseExpresion(_ value: String) -> (String?, String?, String?) {
        guard let match = ParsingHelper.attributedExpresion?.firstMatch(in: value, options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                                        range: NSMakeRange(0, value.count)) else {
            return (nil, nil, nil)
        }
        let ra = match.range(at:1)
        let rb = match.range(at:2)
        let rc = match.range(at:3)
        let a = value.substring(ra)
        let b = value.substring(rb)
        let c = value.substring(rc)
        if a != nil && b == nil {
            return (b, a, c)
        }
        return (a, b, c)
    }
}
