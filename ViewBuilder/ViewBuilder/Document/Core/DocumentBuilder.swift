//
//  DocumentBuilder.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

/**
 Class that serves as an entry point for instantiating documents. 
 Could be extended to customize some aspects but also provideds a `shared` instance for convenience.

 ## Examples

 ```
 // Have document path first
 let pathToDocument = ...

 // User generic load function to build instance
 let view: UIView? = DocumentBuilder.shared.load(pathToDocument, ofType: "xml")
 ```
*/
open class DocumentBuilder: NSObject {

    // Shared instance
    public private(set) static var shared = DocumentBuilder()


    public private(set) var deserializer: DataDeserializerProtocol!

    public private(set) var documentCache: DocumentCacheProtocol!

    public override init() {
        super.init()
        deserializer = createDeserializer()
        documentCache = createDocumentCache()
    }

    /// Extension point that creates default build options to be used.
    open func defaultOptions() -> BuildOptions {
        return BuildOptions()
    }

    /// Extension point to create deserializer to be used.
    open func createDeserializer() -> DataDeserializerProtocol {
        return XMLDataDeserializer()
    }

    /// Extension point to create document cache to be used.
    open func createDocumentCache() -> DocumentCacheProtocol {
        return DefaultDocumentCache()
    }

    @nonobjc
    private func createDocumentKey(_ path: String, options: DocumentOptions) -> DocumentCacheKey {
        return DocumentCacheKey(path: path, namespaces: options.namespaces, includeParsingInfo: options.includeParsingInfo)
    }

    /**
     Loads a document from a given path.

     - Parameter path:    Path to document.
     - Parameter options: Options that will be used in its loading.

     - Returns: A Document from given path. Those are cached and reused.
    */
    public func loadDocument(_ path: String, options: DocumentOptions? = nil) -> DataDocument? {
        let options = options ?? defaultOptions().document
        options.defineDocumentPath(path: path)

        let key = createDocumentKey(path, options: options)
        if let document = documentCache.getDocumentWithKey(key) {
            return document
        }
        guard let dataNode = deserializer.loadData(from: path, options: options) else {
            return nil
        }
        let document = DataDocument(root: dataNode, builder: self, options: options)

        if let document = document {
            let _ = documentCache.saveDocumentWithKey(key, document: document)
        }

        return document
    }

    /**
     Creates a factory for a document.

     - Parameter document:  Document to be used in factory.
     - Parameter options:   Options that will be used within factory.

     - Returns: DocumentFactory associated with this document.
    */
    public func createFactory(_ document: DataDocument, options: FactoryOptions? = nil) -> DocumentFactory {
        let options = options ?? defaultOptions().factory
        return DocumentFactory(document: document, options: options)
    }
}
