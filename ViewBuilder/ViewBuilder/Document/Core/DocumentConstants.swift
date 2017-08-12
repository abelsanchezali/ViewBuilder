//
//  DocumentConstants.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/22/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class Constants {
    public struct Bundle {
        public static let FrameworkBundle =  Foundation.Bundle(for: Constants.self)
    }

    public struct Namespaces {
        public static let FrameworkNamespaceAlias = "framework"
        public static let MainNamespaceAlias = "main"
        public static let DocumentNamespaceAlias = "document"

        public static let FrameworkNamespace = Bundle.FrameworkBundle.bundleIdentifier!
        public static let MainNamespace = Foundation.Bundle.main.bundleIdentifier ?? ""
    }

    public struct Document {
        public static let ContentNodeName = "Content"
        public static let ResourcesNodeName = "Resources"
        public static let PathSeparator = "."
    }
}
