//
//  CollectionViewCellProtocol.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public protocol CollectionViewCellProtocol: AnyObject {
    static func reuseIdentifier() -> String
    static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize
}

public extension CollectionViewCellProtocol {
    static func reuseIdentifier() -> String {
        return String(describing: type(of: self))
    }

    static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        var result = size
        result.width = max(result.width, 0)
        result.height = max(result.height, 0)
        return result
    }
}

public protocol DataSourceReceiverProtocol: AnyObject {
    var dataSource: AnyObject? { get set }
}

public protocol CollectionViewCellDelegate: AnyObject {
    func invalidateCellLayout(_ cell: UICollectionViewCell)
}

public protocol CollectionViewCellWithDelegate: AnyObject {
    var delegate: CollectionViewCellDelegate? { get set }
}

public protocol DocumentAssociatedProtocol {
    var associatedDocumentPath: String? { get }
}

