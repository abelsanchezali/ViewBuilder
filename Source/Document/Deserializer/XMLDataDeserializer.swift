//
//  XMLDataDeserializer.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

class XMLDataDeserializerNSXMLParserDelegate: NSObject, XMLParserDelegate {
    private struct Constants {
        static var moduleWithNameExpresion: NSRegularExpression? = { try! NSRegularExpression(pattern: "^withName\\(([\\w\\.]*)\\)\\s*$",
                                                                                              options: []) }()
    }

    let options: DocumentOptions

    public init(options: DocumentOptions) {
        self.options = options
    }

    var root: DataNode? = nil
    var error: NSError? = nil

    var includeParsingInfo: Bool {
        get {
            return options.includeParsingInfo
        }
    }

    private var current: DataNode? = nil

    private var namespaces = [String:String]()

    func parserDidStartDocument(_ parser: XMLParser) {

    }

    func parserDidEndDocument(_ parser: XMLParser) {

    }

    private func domainForNamespace(_ namespace: String?) -> String? {
        guard let namespace = namespace else {
            return nil
        }

        if namespace.hasPrefix("@") {
            let key = namespace.substring(from: namespace.index(namespace.startIndex, offsetBy: 1))
            // Resolve namespaces with module name
            if let match = Constants.moduleWithNameExpresion?.firstMatch(in: key,
                                                                         options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                                         range: NSMakeRange(0, key.count)),
               let nameParameter = key.substring(match.range(at:1)) {
                return options.resolveNamespaceWithName(nameParameter)
            }
            // Fallback to defined namespaces
            return options.resolveValue(for: key) as? String
        }
        return namespace
    }

    private static let domainSeparator = CharacterSet(charactersIn: ":")

    private func getPrefixAndName(_ text: String) -> (String?, String) {
        guard let range = text.rangeOfCharacter(from: XMLDataDeserializerNSXMLParserDelegate.domainSeparator) else {
            return (nil, text)
        }
        let prefix = text.substring(to: range.lowerBound)
        let name = text.substring(from: range.upperBound)
        return (prefix, name)
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let domain = domainForNamespace(namespaceURI)

        if root == nil {
            root = DataNode(name: elementName, domain: domain)
            current = root
        } else {
            let node = DataNode(name: elementName, domain: domain, parent: current)
            current?.childs.append(node)
            current = node
        }

        for (k, v) in attributeDict {
            let (prefix, name) = getPrefixAndName(k)
            let domain = prefix != nil ? namespaces[prefix!] : nil
            current?.attributes.append(DataAttribute(domain: domain, name: name, text: v))
        }

        if includeParsingInfo {
            current?.debugInfo = DocumentSourceInfo(columnNumber: parser.columnNumber, lineNumber: parser.lineNumber)
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        current?.prefixes = DomainPrefixTable(table: namespaces)
        current = current?.parent
    }

    func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        namespaces[prefix] = domainForNamespace(namespaceURI)
    }

    func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        namespaces.removeValue(forKey: prefix)
    }

    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        root = nil
        error = validationError as NSError?
        Log.shared.write("Validation error ocurred (\(validationError))")
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        root = nil
        error = parseError as NSError?
        Log.shared.write("Parse error ocurred (\(parseError))")
    }

}

public class XMLDataDeserializer: DataDeserializerProtocol {

    public class var identifier: String { return "XML" }

    public required init() { }

    open func loadData(from path: String, options: DocumentOptions) -> DataNode? {
        guard let parser = XMLParser(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        let delegate = XMLDataDeserializerNSXMLParserDelegate(options: options)
        parser.delegate = delegate
        parser.parse()
        return delegate.root
    }
}
