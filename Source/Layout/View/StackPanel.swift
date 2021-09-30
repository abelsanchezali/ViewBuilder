//
//  StackPanel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class StackPanel: PanelBase {

    // MARK: - Properties

    @objc open var orientation: LayoutOrientation = .vertical {
        didSet {
            invalidateLayout()
        }
    }

    @objc open override var padding: UIEdgeInsets {
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
        view.addObserver(self, forKeyPath: "priority", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "flexibility", options: .new, context: nil)
        isDirtySortedViews = true
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
        view.removeObserver(self, forKeyPath: "priority")
        view.removeObserver(self, forKeyPath: "flexibility")
        isDirtySortedViews = true
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Invalidate sorted array of some subview change its priority
        if keyPath == "priority" {
            isDirtySortedViews = true
        }
        invalidateLayout()
    }

    private var isDirtySortedViews = true
    private var sortedViews = [UIView]()

    // MARK: - Layout

    open override func layoutOverride(_ currentSize: CGSize) {
        let padding = self.padding
        let orientation = self.orientation
        let size = CGSize(width: max(currentSize.width - padding.totalWidth, 0),
                          height: max(currentSize.height - padding.totalHeight, 0))
        var offset = CGPoint.zero
        // Calculate remaing spaces and flexibility
        var remainingSpace: CGFloat = orientation == .vertical ? size.height : size.width
        var totalFlexibility: CGFloat = 0
        for view in subviews {
            if view.isSkipingLayout {
                continue
            }
            if orientation == .vertical {
                remainingSpace -= view.measuredSize.height + view.margin.totalHeight
            } else {
                remainingSpace -= view.measuredSize.width + view.margin.totalWidth
            }
            totalFlexibility += CGFloat(view.flexibility)
        }
        // Adjust sizes if we have some remaining space and flexible childs
        if totalFlexibility > 0 && remainingSpace > 0 {
            for view in subviews {
                if view.isSkipingLayout {
                    continue
                }
                let flexibility = CGFloat(view.flexibility)
                if flexibility == 0 {
                    continue
                }
                if orientation == .vertical {
                    view.measuredSize.height += remainingSpace * totalFlexibility / flexibility
                } else {
                    view.measuredSize.width += remainingSpace * totalFlexibility / flexibility
                }
            }
        }
        // Layout subviews
        for view in subviews {
            if view.isSkipingLayout {
                continue
            }
            let measuredSize = view.measuredSize
            let margin = view.margin
            let verticalAlignment = view.verticalAlignment
            let horizontalAlignment = view.horizontalAlignment
            let maxWidth = orientation == .vertical ? size.width : measuredSize.width + margin.totalWidth
            let maxHeight = orientation == .horizontal ? size.height : measuredSize.height + margin.totalHeight
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
            if orientation == .vertical {
                finalRect.origin.y += offset.y
                offset.y += finalRect.height + margin.totalHeight
            } else {
                finalRect.origin.x += offset.x
                offset.x += finalRect.width + margin.totalWidth
            }
            view.arrangeToRect(finalRect)
            view.layoutSubviews()
        }
    }

    // MARK: - Measure

    open override func measureOverride(_ size: CGSize) -> CGSize {
        var availiableSize = CGSize(width: max(size.width - padding.totalWidth, 0),
                                    height: max(size.height - padding.totalHeight, 0))
        var preferredSize = CGSize.zero
        // Rebuild sortedViews array if its invalid
        if isDirtySortedViews {
            sortedViews = subviews.sorted { (a, b) -> Bool in
                return a.priority > b.priority
            }
            isDirtySortedViews = false
        }
        for view in sortedViews {
            let viewSize = view.measureForLayout(availiableSize)
            if orientation == .vertical {
                preferredSize.width = max(viewSize.width, preferredSize.width)
                preferredSize.height += viewSize.height
                availiableSize.height -= viewSize.height
            } else {
                preferredSize.height = max(viewSize.height, preferredSize.height)
                preferredSize.width += viewSize.width
                availiableSize.width -= viewSize.width
            }
        }
        preferredSize.width += padding.totalWidth
        preferredSize.height += padding.totalHeight
        preferredSize.width = min(preferredSize.width, size.width)
        preferredSize.height = min(preferredSize.height, size.height)
        return preferredSize
    }
}
