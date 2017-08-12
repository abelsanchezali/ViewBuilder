//
//  Converter.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 11/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class Converter {
    static let colors : [UIColor] = [UIColor.red, UIColor.blue, UIColor.brown, UIColor.green, UIColor.black, UIColor.orange, UIColor.orange, UIColor.darkGray, UIColor.cyan, UIColor.magenta, UIColor.purple]

    public class func intToColor(_ source: Int) -> UIColor {
        return colors[abs(source % colors.count)]
    }
}
