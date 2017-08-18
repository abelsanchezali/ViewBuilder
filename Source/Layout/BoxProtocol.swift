//
//  BoxProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public protocol BoxProtocol {
    // Distance to any sibling in all four edges
    var margin: UIEdgeInsets { get set }
    // Distance to child content in all four edges
    var padding: UIEdgeInsets { get set }
    // Preferred size for this element
    var preferredSize: CGSize { get set }
    // Maximum size for this element
    var maximumSize: CGSize { get set }
}
