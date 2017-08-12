//
//  Color.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class Color: Object, TextDeserializer {

    static let ColorsByName: [String: UIColor] = ["Black": UIColor.black,
                                                  "Blue": UIColor.blue,
                                                  "Brown": UIColor.brown,
                                                  "Clear": UIColor.clear,
                                                  "Cyan": UIColor.cyan,
                                                  "DarkGray": UIColor.darkGray,
                                                  "DarkText": UIColor.darkText,
                                                  "Gray": UIColor.gray,
                                                  "Green": UIColor.green,
                                                  "LightGray": UIColor.lightGray,
                                                  "LightText": UIColor.lightText,
                                                  "Magenta": UIColor.magenta,
                                                  "Orange": UIColor.orange,
                                                  "Purple": UIColor.purple,
                                                  "Red": UIColor.red,
                                                  "White": UIColor.white,
                                                  "Yellow": UIColor.yellow]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let array = service.parseHexadecimalComponent(from: value) {
            if array.count == 3 {
                return UIColor(red: CGFloat(array[0]) / 255.0, green: CGFloat(array[1]) / 255.0, blue: CGFloat(array[2]) / 255.0, alpha: 1)
            }
            if array.count == 4 {
                return UIColor(red: CGFloat(array[0]) / 255.0, green: CGFloat(array[1]) / 255.0, blue: CGFloat(array[2]) / 255.0, alpha: CGFloat(array[3]) / 255.0)
            }
        }
        if let array = service.parseValidIntegerArray(from: value) {
            if array.count == 3 {
                return UIColor(red: CGFloat(array[0]) / 255.0, green: CGFloat(array[1]) / 255.0, blue: CGFloat(array[2]) / 255.0, alpha: 1)
            }
            if array.count == 4 {
                return UIColor(red: CGFloat(array[0]) / 255.0, green: CGFloat(array[1]) / 255.0, blue: CGFloat(array[2]) / 255.0, alpha: CGFloat(array[3]) / 255.0)
            }
        }
        if let array = service.parseValidDoubleArray(from: value) {
            if array.count == 3 {
                return UIColor(red: CGFloat(array[0]), green: CGFloat(array[1]), blue: CGFloat(array[2]), alpha: 1)
            }
            if array.count == 4 {
                return UIColor(red: CGFloat(array[0]), green: CGFloat(array[1]), blue: CGFloat(array[2]), alpha: CGFloat(array[3]))
            }
        }
        return Color.ColorsByName[value.trimmingCharacters(in: CharacterSet.whitespaces)]
    }
}

extension UIColor: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Color.deserialize(text: text, service: service)
    }
}
