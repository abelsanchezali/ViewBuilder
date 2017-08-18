//
//  FittingView.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 9/10/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class FittingView: UIViewAttachable {
    public var subview: UIView?
    public var margin: NSValue? = nil

    public override func add(item: Any) -> Bool {
        guard let view = item as? UIView else {
            return false
        }
        subview = view
        return true
    }

    public override func performAttachmentToView(_ view: UIView) {
        guard let subview = subview else {
            Log.shared.write("Warning: Missing subview to attach to {\(view)}")
            return
        }
        let margin = self.margin?.uiEdgeInsetsValue ?? subview.margin
        view.addSubview(subview)
        ManualLayoutHelper.fitViewInContainer(subview, container: view, margin: margin)
    }

}
