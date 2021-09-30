//
//  PanelBase.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

@objc
open class PanelBase: UIView {

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        PanelBase.patchClasses
    }

    // MARK: - Subviews Connections

    open func connectToView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = true
      view.autoresizingMask = UIView.AutoresizingMask()
    }

    open func disconnectFromView(_ view: UIView) {

    }

    // MARK: - Subviews Addition/Removal

    open override func willRemoveSubview(_ view: UIView) {
        disconnectFromView(view)
        super.willRemoveSubview(view)
        invalidateLayout()
    }

    open override func didAddSubview(_ subview: UIView) {
        connectToView(subview)
        super.didAddSubview(subview)
        invalidateLayout()
    }

    open override func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        super.exchangeSubview(at: index1, withSubviewAt: index2)
        invalidateLayout()
    }

    open override func bringSubviewToFront(_ view: UIView) {
        super.bringSubviewToFront(view)
        invalidateLayout()
    }

    open override func sendSubviewToBack(_ view: UIView) {
        super.sendSubviewToBack(view)
        invalidateLayout()
    }

    // MARK: - Measurement

    open override func subviewMeasureChanged(_ subview: UIView) {
        if subview.isSkipingLayout {
            return
        }
        invalidateLayout()
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        measure(size)
        return measuredSize
    }

    open override func measureOverride(_ size: CGSize) -> CGSize {
        return super.measureOverride(size)
    }

    // MARK: - Layout

    open override func setNeedsLayout() {
        super.setNeedsLayout()
        invalidateMeasure()
    }

    open private(set) var isLayoutRunning = false

    open func invalidateLayout() {
        if isLayoutRunning {
            return
        }
        setNeedsLayout()
    }

    open func beginLayout() {
        isLayoutRunning = true
    }

    open func endLayout() {
        isLayoutRunning = false
    }

    open func layoutOverride(_ currentSize: CGSize) {

    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        beginLayout()

        let currentSize = bounds.size
        
        measure(currentSize)
        layoutOverride(currentSize)
        
        endLayout()
    }
}
