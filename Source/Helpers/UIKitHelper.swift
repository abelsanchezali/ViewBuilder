//
//  UIKitHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class UIKitHelper: NSObject {

    public static func loadViewFromNibName(_ nibName: String, bundle: Foundation.Bundle, viewType: UIView.Type) -> UIView? {
        guard let objects = bundle.loadNibNamed(nibName, owner: nil, options: nil) else {
            return nil
        }
        for obj in objects {
            if (obj as AnyObject).isKind(of: viewType) {
                return obj as? UIView
            }
        }
        return nil
    }
}
