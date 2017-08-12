//
//  UIStackView+DocumentChildProcessor.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/3/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder

extension UIStackView {
    open override func processDocument(childs: DocumentChildVisitor) {
        childs.visit { (child) -> Bool in
            if let subview = child as? UIView {
                subview.translatesAutoresizingMaskIntoConstraints = false
                addArrangedSubview(subview)
                return true
            }
            return false
        }
        super.processDocument(childs: childs)
    }
}
