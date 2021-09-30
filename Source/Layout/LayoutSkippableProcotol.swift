//
//  LayoutSkippableProcotol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

@objc public protocol LayoutSkippableProcotol {
    // True element is hidden and will not be displayed, otherwise false
    var isHidden: Bool { @objc(isHidden) get @objc(setHidden:) set }
    // True if element will not count for layout when hidden, otherwise false
    var collapsable: Bool { get set }
    // True if element will not count for layout and his position and size will be handled manually regarding any other property, otherwise false
    var detached: Bool { get set }
}

extension LayoutSkippableProcotol {
    public var isSkipingLayout: Bool {
        return (isHidden && collapsable) || detached
    }
}
