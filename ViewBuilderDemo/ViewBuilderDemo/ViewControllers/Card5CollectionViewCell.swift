//
//  Card5CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class Card5CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol {
    static let shared = Card5CollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    var summaryLabel: UILabel!
    var insightLabel: UILabel!
    var imageView: UIView!
    var button: UIButton!
    var container: PanelBase!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        container = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "SampleCard5", ofType: "xml")!)
        contentView.addSubview(container)
        ManualLayoutHelper.fitViewInContainer(container, container: contentView)

        summaryLabel = container.documentReferences!["summaryLabel"] as! UILabel
        insightLabel = container.documentReferences!["insightLabel"] as! UILabel
        imageView = container.documentReferences!["imageView"] as! UIView
        button = container.documentReferences!["button"] as! UIButton
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? = nil {
        didSet {
            let dataSource = self.dataSource as? ViewModel
            let summary = dataSource?["summary"] as? String
            let insight = dataSource?["insight"] as? String
            let action = dataSource?["action"] as? String
            let mode = dataSource?["mode"] as? Int ?? 0
            summaryLabel.text = summary
            insightLabel.text = insight
            imageView.backgroundColor = Converter.intToColor(mode)
            button.setTitle(action, for: UIControlState())
        }
    }
}

extension Card5CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        let width = size.width - shared.margin.totalWidth
        shared.dataSource = dataSource
        let neededSize = shared.container.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let finalSize = CGSize(width: width, height: neededSize.height)
        return finalSize
    }
}

extension Card5CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard5", ofType: "xml") }
}
