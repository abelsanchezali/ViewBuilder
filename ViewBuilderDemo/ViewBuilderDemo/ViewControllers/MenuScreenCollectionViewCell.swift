//
//  MenuScreenCollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class MenuScreenCollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol {

    var container: PanelBase!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        container = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "MenuScreenCollectionViewCell", ofType: "xml")!)
        contentView.addSubview(container)
        ManualLayoutHelper.fitViewInContainer(container, container: contentView)

        titleLabel = container.documentReferences!["titleLabel"] as! UILabel
        descriptionLabel = container.documentReferences!["descriptionLabel"] as! UILabel
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? {
        didSet {
            let dataSource = self.dataSource as? ScreenDescriptionModel
            titleLabel.text = dataSource?.title
            descriptionLabel.text = dataSource?.summary
        }
    }
}

extension MenuScreenCollectionViewCell: CollectionViewCellProtocol {
    @nonobjc static let shared = MenuScreenCollectionViewCell()

    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        let width = size.width - shared.margin.totalWidth
        shared.dataSource = dataSource
        let neededSize = shared.container.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let finalSize = CGSize(width: width, height: neededSize.height)
        return finalSize
    }
}
