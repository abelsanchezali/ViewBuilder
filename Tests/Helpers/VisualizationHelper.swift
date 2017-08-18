//
//  VisualizationHelper.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/21/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

class VisualizationHelper {
    class func imageFor(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
