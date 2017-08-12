//
//  DictionaryTextDeserializerServiceProtocolDelegate.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/18/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit
@testable import ViewBuilder

class DictionaryTextDeserializerServiceProtocolDelegate: TextDeserializerServiceProtocolDelegate {
    init() {

    }

    init(values: [String: Any], domains: [String: String] = [:]) {
        self.values = values
        self.domains = domains
    }

    var values = [String: Any]()
    var domains = [String: String]()

    // MARK: KeyValueResolverProtocol

    func resolveValue(for key: String) -> Any? {
        if key.hasPrefix(DocumentFactory.DomainsValuesPrefix) {
            return resolveDomain(for: key.substring(from: key.characters.index(key.startIndex, offsetBy: DocumentFactory.DomainsValuesPrefixLength)))
        }
        return values[key]
    }

    // MARK: TextDeserializerServiceProtocolDelegate

    func resolveDomain(for prefix: String) -> String? {
        return domains[prefix]
    }
}
