//
//  Card4CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class Card4CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol {
    static let shared = Card4CollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    var summaryLabel: UILabel!
    var insightLabel: UILabel!
    var imageView: UIView!
    var separatorView: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        if !self.contentView.loadFromDocument(Constants.bundle.path(forResource: "SampleCard4", ofType: "xml")!) {
            fatalError("Ups!!!")
        }
        summaryLabel = self.contentView.documentReferences!["summaryLabel"] as! UILabel
        insightLabel = self.contentView.documentReferences!["insightLabel"] as! UILabel
        imageView = self.contentView.documentReferences!["imageView"] as! UIView
        separatorView = self.contentView.documentReferences!["separator"] as!UIView
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? = nil {
        didSet {
            let dataSource = self.dataSource as? ViewModel
            let summary = dataSource?["summary"] as? String
            let insight = dataSource?["insight"] as? String
            let mode = dataSource?["mode"] as? Int ?? 0
            var color = UIColor.red
            switch mode {
            case 1:
                color = UIColor.blue
            case 2:
                color = UIColor.brown
            case 3:
                color = UIColor.green
            case 4:
                color = UIColor.black
            case 5:
                color = UIColor.orange
            case 6:
                color = UIColor.darkGray
            case 7:
                color = UIColor.cyan
            case 8:
                color = UIColor.magenta
            case 9:
                color = UIColor.purple
            default:
                color = UIColor.red
            }
            summaryLabel.text = summary
            insightLabel.text = insight
            imageView.backgroundColor = color
        }
    }

    public override func layoutSubviews() {
        // Measure Subviews
        // Arrange Subviews
    }

    static let borderMargin: CGFloat = 12.0
    static let itemMargin: CGFloat = 8
}

extension Card4CollectionViewCell: CollectionViewCellProtocol {

    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        let width = size.width - shared.margin.left - shared.margin.right

        shared.dataSource = dataSource
        shared.imageView.frame = CGRect(x: borderMargin,
                                        y: borderMargin,
                                        width: shared.imageView.bounds.size.width,
                                        height: shared.imageView.bounds.size.width)
        let summarySize = shared.summaryLabel.sizeThatFits(CGSize(width: width - borderMargin * 2 - itemMargin, height: CGFloat.greatestFiniteMagnitude))
        shared.summaryLabel.frame = CGRect(x: shared.imageView.bounds.size.width + itemMargin,
                                           y: borderMargin,
                                           width: summarySize.width,
                                           height: summarySize.height)

        let measure = CGSize(width: width, height: 250)
        return measure
    }
}

extension Card4CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard4", ofType: "xml") }
}
