//
//  DocumentFactory+Build.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: Build

public extension DocumentFactory {

    func buildObject(_ options: InstantiationOptions? = nil) -> Any? {
        let options = options ?? InstantiationOptions()
        return buildNode(document.baseNode, instance: options.baseInstance)
    }

    func build<T>(_ options: InstantiationOptions? = nil) -> T? {
        let options = options ?? InstantiationOptions()
        guard let _ = document.baseNode.referenceType as? T.Type else {
            if options.verbose {
                Log.shared.write("Reference type is not \(String(describing: T.self)) in node = \(document.baseNode).")
            }
            return nil
        }
        return buildNode(document.baseNode, instance: options.baseInstance) as? T
    }

    func buildResources(_ options: InstantiationOptions? = nil) -> Resources? {
        return build(options)
    }
}

// MARK: UIKit

public extension DocumentFactory {
    func buildView(_ options: InstantiationOptions? = nil) -> UIView? {
        return build(options)
    }
}
