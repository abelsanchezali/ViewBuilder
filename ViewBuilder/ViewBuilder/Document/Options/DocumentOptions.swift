//
//  DocumentOptions.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class DocumentOptions: NSObject, KeyValueResolverProtocol {
    open var verbose = true

    open var includeParsingInfo: Bool = true
    open private(set) var namespaces = [String:String]()
    open private(set) var documentPath: String? = nil
    open private(set) var documentNamespace: String? = nil

    public override init() {
        namespaces[Constants.Namespaces.FrameworkNamespaceAlias] = Constants.Namespaces.FrameworkNamespace
        namespaces[Constants.Namespaces.MainNamespaceAlias] = Constants.Namespaces.MainNamespace
    }

    open func resolveValue(for key: String) -> Any? {
        if key == Constants.Namespaces.DocumentNamespaceAlias {
            return resolveDocumentNamespace()
        }
        return namespaces[key]
    }

    open func resolveNamespaceWithName(_ name: String) -> String? {
        return ReflectionHelper.findBundleWithModuleName(name)?.bundleIdentifier
    }

    func resolveDocumentNamespace() -> String? {
        if let namespace = documentNamespace {
            return namespace.isEmpty ? nil : namespace
        }
        guard let path = documentPath else {
            return nil
        }
        documentNamespace = ReflectionHelper.findBundleForPath(path)?.bundleIdentifier ?? ""
        return resolveDocumentNamespace()
    }

    open func defineDocumentPath(path: String?) {
        documentPath = path
        documentNamespace = nil
    }
}
