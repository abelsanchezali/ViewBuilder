//
//  DocumentModel.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 10/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class DocumentModel: NSObject {
    public var name: String?
    public var bundleIdentifier: String?
}

extension DocumentModel {
    public func documentPath() -> String? {
        guard let identifier = bundleIdentifier else {
            return nil
        }
        return Bundle(identifier: identifier)?.path(forResource: name, ofType: nil)
    }
}
