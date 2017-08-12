//
//  UIScrollView+Utils.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIScrollView {
    public func scrollToBottom(_ animated: Bool) {
        let offset = CGPoint(x: contentOffset.x, y: contentSize.height - bounds.size.height)
        self.setContentOffset(offset, animated: animated)
    }

    public func scrollToTop(_ animated: Bool) {
        let offset = CGPoint(x: contentOffset.x, y: 0)
        self.setContentOffset(offset, animated: animated)
    }

    public func scrollToRight(_ animated: Bool) {
        let offset = CGPoint(x: contentSize.width - bounds.size.width, y: contentOffset.y)
        self.setContentOffset(offset, animated: animated)
    }

    public func scrollToLeft(_ animated: Bool) {
        let offset = CGPoint(x: contentSize.width - bounds.size.width, y: 0)
        self.setContentOffset(offset, animated: animated)
    }

}
