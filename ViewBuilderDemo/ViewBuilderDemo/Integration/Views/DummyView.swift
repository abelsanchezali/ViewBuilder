//
//  DummyView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class DummyView: UIView {
    override public class var layerClass : AnyClass {
        return CATransformLayer.self
    }
}
