//
//  ConstantsHelper.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/21/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

class ConstantsHelper {
    struct Bundles {
        static let UIKitBundle = Foundation.Bundle(for: UIView.self)
        static let ViewBuilderBundle = Foundation.Bundle(for: DocumentBuilder.self)
        static let TestBundle = Foundation.Bundle(for: BaseDeserializerTests.self)

        static let UIKitBundleIdentifier = Foundation.Bundle(for: UIView.self).bundleIdentifier!
        static let ViewBuilderBundleIdentifier = Foundation.Bundle(for: DocumentBuilder.self).bundleIdentifier!
        static let TestBundleIdentifier = Foundation.Bundle(for: BaseDeserializerTests.self).bundleIdentifier!
    }
}
