//
//  DocumentBuilder+Build.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/13/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: Build

extension DocumentBuilder {
    /**
     Create an instance of given type T from document. 
     If document does not match type or path is not valid will fail.

     - Parameter path:     Path to Document.
     - Parameter options:  Options to be used during build process.
     
     - Returns: An instance of type T described in document.
    */
    public func load<T>(_ path: String, options: BuildOptions? = nil) -> T? {
        let options = options ?? defaultOptions()
        guard let document = loadDocument(path, options: options.document) else {
            return nil
        }
        let factory = createFactory(document, options: options.factory)
        return factory.build(options.instantiation)
    }

    /**
     Create an any instance reoresented in document. If document path is not valid will fail.

     - Parameter path:     Path to Document.
     - Parameter options:  Options to be used during build process.

     - Returns: An instance of type T described in document.
    */
    public func loadObject(_ path: String, options: BuildOptions? = nil) -> Any? {
        let options = options ?? defaultOptions()
        guard let document = loadDocument(path, options: options.document) else {
            return nil
        }
        let factory = createFactory(document, options: options.factory)
        return factory.buildObject(options.instantiation)
    }
}

// MARK: UIKit

extension DocumentBuilder {
    public func loadView(_ path: String, options: BuildOptions? = nil) -> UIView? {
        return load(path, options: options)
    }

    public func loadResources(_ path: String, options: BuildOptions? = nil) -> Resources? {
        return load(path, options: options)
    }
}

