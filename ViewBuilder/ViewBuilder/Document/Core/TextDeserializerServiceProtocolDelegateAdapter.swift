//
//  TextDeserializerServiceProtocolDelegateAdapter.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/23/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

class TextDeserializerServiceProtocolDelegateAdapter: TextDeserializerServiceProtocolDelegate {

    public var resolveDomainForPrefixBlock: ((_ prefix: String) -> String?)? = nil
    public var resolveValueForKeyBlock: ((_ key: String) -> Any?)? = nil

    func resolveDomain(for prefix: String) -> String? {
        return resolveDomainForPrefixBlock?(prefix)
    }

    func resolveValue(for key: String) -> Any? {
        return resolveValueForKeyBlock?(key)
    }
}
