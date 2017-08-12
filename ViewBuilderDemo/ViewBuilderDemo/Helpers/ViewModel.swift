//
//  ViewModel.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/27/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class ViewModel {
    var data = [String: Any]()

    public subscript(key: String) -> Any? {
        set {
            if newValue != nil {
                data[key] = newValue
            } else {
                data.removeValue(forKey: key)
            }
        }
        get {
            return data[key]
        }
    }
}
