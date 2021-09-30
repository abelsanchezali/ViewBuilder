//
//  ScrollPanel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 9/19/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class ScrollPanel: UIScrollView {

    // MARK: - Properties

    @objc open var orientation: NSNumber? = nil {
        didSet {
            invalidateLayout()
        }
    }

    @objc open weak var contentView: UIView? {
        willSet {
            if let view = contentView {
                disconnectFromView(view)
            }
        }
        didSet {
            if let view = contentView {
                connectToView(view)
            }
            invalidateLayout()
        }
    }
    
    @objc open override var padding: UIEdgeInsets {
        didSet {
            invalidateLayout()
        }
    }

    // MARK: - Subviews Connections

    open func connectToView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = true
      view.autoresizingMask = UIView.AutoresizingMask()
        view.addObserver(self, forKeyPath: "margin", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "collapsable", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "hidden", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "preferredSize", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "maximumSize", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "detached", options: .new, context: nil)
    }

    open func disconnectFromView(_ view: UIView) {
        view.removeObserver(self, forKeyPath: "margin")
        view.removeObserver(self, forKeyPath: "collapsable")
        view.removeObserver(self, forKeyPath: "hidden")
        view.removeObserver(self, forKeyPath: "preferredSize")
        view.removeObserver(self, forKeyPath: "maximumSize")
        view.removeObserver(self, forKeyPath: "detached")
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        invalidateLayout()
    }

    // MARK: - Subviews Addition/Removal

    open override func willRemoveSubview(_ subview: UIView) {
        if contentView == subview {
            contentView = nil
        }
        super.willRemoveSubview(subview)
        invalidateLayout()
    }

    open override func didAddSubview(_ subview: UIView) {
        if contentView == nil {
            contentView = subview
        }
        super.didAddSubview(subview)
        invalidateLayout()
    }

    // MARK: - Measure

    open override func subviewMeasureChanged(_ subview: UIView) {
        if subview.isSkipingLayout || subview != contentView{
            return
        }
        invalidateLayout()
    }

    open override func measureOverride(_ size: CGSize) -> CGSize {
        let padding = self.padding
        var availiableSize = CGSize(width: max(size.width - padding.totalWidth, 0),
                                    height: max(size.height - padding.totalHeight, 0))
        var preferredSize = CGSize.zero

        var orientation: LayoutOrientation? = nil

        if self.orientation != nil {
            orientation = LayoutOrientation(rawValue: self.orientation!.intValue)
        }

        switch orientation {
        case .some(.vertical):
            availiableSize.height = CGFloat.largeValue
        case .some(.horizontal):
            availiableSize.width = CGFloat.largeValue
        case .none:
            availiableSize.height = CGFloat.largeValue
            availiableSize.width = CGFloat.largeValue
        }

        let viewSize = contentView?.measureForLayout(availiableSize) ?? CGSize.zero
        preferredSize.width = max(preferredSize.width, viewSize.width)
        preferredSize.height = max(preferredSize.height, viewSize.height)

        preferredSize.width += (padding.totalWidth)
        preferredSize.height += (padding.totalHeight)
        return preferredSize
    }

    // MARK: - Layout

    private var lastLayoutSize = CGSize.zero

    open override func setNeedsLayout() {
        super.setNeedsLayout()
        invalidateMeasure()
    }

    open private(set) var isLayoutRunning = false
    private var forceLayout = true

    open func invalidateLayout() {
        if isLayoutRunning {
            return
        }
        forceLayout = true
        setNeedsLayout()
    }

    open func beginLayout() {
        isLayoutRunning = true
    }

    open func endLayout() {
        isLayoutRunning = false
    }

    open func layoutOverride(_ currentSize: CGSize) {
        guard let view = contentView, !view.isSkipingLayout else {
            return
        }
        let padding = self.padding
        let size = CGSize(width: max(currentSize.width - padding.totalWidth, 0),
                          height: max(currentSize.height - padding.totalHeight, 0))
        let margin = view.margin
        let measuredSize = view.measuredSize
        var maxWidth = measuredSize.width + margin.totalWidth
        var maxHeight = measuredSize.height + margin.totalHeight
        if let value = self.orientation {
            let orientation = LayoutOrientation(rawValue: value.intValue)
            if orientation == .vertical {
                maxWidth = size.width
            } else {
                maxHeight = size.height
            }
        }
        maxWidth = max(maxWidth, size.width)
        maxHeight = max(maxHeight, size.height)
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
        contentSize = CGSize(width: finalRect.maxX + padding.right + margin.right, height: finalRect.maxY + padding.bottom + margin.bottom)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        let currentSize = bounds.size
        guard currentSize != lastLayoutSize || forceLayout else {
            return
        }
        lastLayoutSize = currentSize
        forceLayout = false

        beginLayout()

        measure(currentSize)
        layoutOverride(currentSize)

        endLayout()
    }
}
