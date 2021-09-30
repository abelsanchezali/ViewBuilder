//
//  PanelLayoutProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/29/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

@objc
public protocol PanelLayoutProtocol: BoxProtocol, LayoutSkippableProcotol {
    // Last size measured using func measure(:)
    var measuredSize: CGSize { get set }

    // This function will provide intrinsic size for this element, margins are not included
    func measureOverride(_ size: CGSize) -> CGSize

    // Will let know a element that some of his childs measure is no longer valid
    func subviewMeasureChanged(_ subview: UIView)

    // Will arrange this view to fit this rect
    func arrangeToRect(_ rect: CGRect)
}

extension PanelLayoutProtocol {
    public func measureForLayout(_ size: CGSize) -> CGSize {
        if isSkipingLayout {
            return CGSize.zero
        }
        let margin = self.margin
        let availiableSize = CGSize(width: max(size.width - margin.totalWidth, 0),
                                    height: max(size.height - margin.totalHeight, 0))

        measure(availiableSize)
        var finalSize = measuredSize
        finalSize.width += margin.totalWidth
        finalSize.height += margin.totalHeight
        return finalSize
    }

    public func measure(_ size: CGSize) {
        var preferredSize = self.preferredSize
        let maximumSize = self.maximumSize
        let hasWidth = preferredSize.width > 0, hasHeight = preferredSize.height > 0
        let maximumWidth = maximumSize.width < 0 ? CGFloat.largeValue : maximumSize.width,
        maximumHeight = maximumSize.height < 0 ? CGFloat.largeValue : maximumSize.height
        if !hasWidth {
            preferredSize.width = size.width
        }
        preferredSize.width = min(preferredSize.width, maximumWidth)
        if !hasHeight {
            preferredSize.height = size.height
        }
        preferredSize.height = min(preferredSize.height, maximumHeight)
        preferredSize = CGSize(width: min(preferredSize.width, size.width),
                               height: min(preferredSize.height, size.height))
        var neededSize = measureOverride(preferredSize)
        if hasWidth {
            neededSize.width = min(preferredSize.width, maximumWidth)
        }
        if hasHeight {
            neededSize.height = min(preferredSize.height, maximumHeight)
        }
        measuredSize = neededSize
    }

    public func invalidateMeasure() {
        
    }
}
