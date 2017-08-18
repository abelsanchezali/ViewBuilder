//
//  Panel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class Panel: PanelBase {
    
    // MARK: - Properties

    open override var padding: UIEdgeInsets {
        didSet {
            invalidateLayout()
        }
    }

    // MARK: - Connection

    open override func connectToView(_ view: UIView) {
        super.connectToView(view)
        view.addObserver(self, forKeyPath: "margin", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "collapsable", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "hidden", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "verticalAlignment", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "horizontalAlignment", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "preferredSize", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "maximumSize", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "detached", options: .new, context: nil)
    }

    open override func disconnectFromView(_ view: UIView) {
        super.disconnectFromView(view)
        view.removeObserver(self, forKeyPath: "margin")
        view.removeObserver(self, forKeyPath: "collapsable")
        view.removeObserver(self, forKeyPath: "hidden")
        view.removeObserver(self, forKeyPath: "verticalAlignment")
        view.removeObserver(self, forKeyPath: "horizontalAlignment")
        view.removeObserver(self, forKeyPath: "preferredSize")
        view.removeObserver(self, forKeyPath: "maximumSize")
        view.removeObserver(self, forKeyPath: "detached")
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        invalidateLayout()
    }

    // MARK: - Layout
    
    open override func layoutOverride(_ currentSize: CGSize) {
        let padding = self.padding
        let size = CGSize(width: max(currentSize.width - padding.totalWidth, 0),
                          height: max(currentSize.height - padding.totalHeight, 0))
        let maxWidth = size.width
        let maxHeight = size.height
        for view in subviews {
            if view.isSkipingLayout {
                continue
            }
            let measuredSize = view.measuredSize
            let margin = view.margin
            let verticalAlignment = view.verticalAlignment
            let horizontalAlignment = view.horizontalAlignment
            let vertical = ManualLayoutHelper.linearLayout(measuredSize.width,
                                                           before: margin.left,
                                                           after: margin.right,
                                                           available: maxWidth,
                                                           alignment: horizontalAlignment)
            let horizontal = ManualLayoutHelper.linearLayout(measuredSize.height,
                                                             before: margin.top,
                                                             after: margin.bottom,
                                                             available: maxHeight,
                                                             alignment: verticalAlignment)
            var finalRect = CGRect(origin: CGPoint(x: vertical.0, y: horizontal.0),
                                   size: CGSize(width: vertical.1 - vertical.0, height: horizontal.1 - horizontal.0))
            finalRect.origin.x += padding.left
            finalRect.origin.y += padding.top
            view.arrangeToRect(finalRect)
            view.layoutSubviews()
        }
    }

    // MARK: - Measure

    open override func measureOverride(_ size: CGSize) -> CGSize {
        let padding = self.padding
        let availiableSize = CGSize(width: max(size.width - padding.totalWidth, 0),
                                    height: max(size.height - padding.totalHeight, 0))
        var preferredSize = CGSize.zero

        for view in subviews {
            let viewSize = view.measureForLayout(availiableSize)
            preferredSize.width = max(preferredSize.width, viewSize.width)
            preferredSize.height = max(preferredSize.height, viewSize.height)
        }

        preferredSize.width += (padding.totalWidth)
        preferredSize.height += (padding.totalHeight)
        return preferredSize
    }
}
