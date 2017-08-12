//
//  UICollectionViewConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class UICollectionViewConstructor: ObjectConstructor {
    private static let LayoutParameter = "layout"
    private static let Parameters = [UICollectionViewConstructor.LayoutParameter]

    open func parametersKeys() -> [String] {
        return UICollectionViewConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? UICollectionView.Type else {
            return nil
        }
        if let layout = parameters[UICollectionViewConstructor.LayoutParameter] as? UICollectionViewLayout {
            return type.init(frame: CGRect.zero, collectionViewLayout: layout)
        }
        return type.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
}

extension UICollectionView {
    private static let objectConstructor = UICollectionViewConstructor()

    public override class func resolveObjectConstructor() -> ObjectConstructor {
        return UICollectionView.objectConstructor
    }
}
