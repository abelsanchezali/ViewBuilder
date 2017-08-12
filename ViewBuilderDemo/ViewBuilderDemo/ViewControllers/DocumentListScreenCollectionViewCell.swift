//
//  DocumentListScreenCollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 10/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class DocumentListScreenCollectionViewCell: UICollectionViewCell {
    var container: PanelBase!
    var nameLabel: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        container = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "DocumentListScreenCollectionViewCell", ofType: "xml")!)
        contentView.addSubview(container)
        ManualLayoutHelper.fitViewInContainer(container, container: contentView)
        nameLabel = container.documentReferences!["nameLabel"] as! UILabel
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? {
        didSet {
            let dataSource = self.dataSource as? DocumentModel
            nameLabel.text = dataSource?.name
        }
    }
}

extension DocumentListScreenCollectionViewCell: CollectionViewCellProtocol {
    @nonobjc static let shared = DocumentListScreenCollectionViewCell()

    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        let width = size.width - shared.margin.totalWidth
        shared.dataSource = dataSource
        let neededSize = shared.container.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let finalSize = CGSize(width: width, height: neededSize.height)
        return finalSize
    }
}
