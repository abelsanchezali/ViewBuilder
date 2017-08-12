//
//  UICollectionViewControllerInitializationParameter.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public protocol UICollectionViewControllerInitializationParameter {
    var initializationParameter: AnyObject? { get set }
}