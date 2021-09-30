//
//  Card0CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class Card0CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol {
    static let shared = Card0CollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    var summaryLabel: UILabel!
    var insightLabel: UILabel!
    var imageView: UIView!
    var button: UIButton!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        if !self.contentView.loadFromDocument(Constants.bundle.path(forResource: "SampleCard0", ofType: "xml")!) {
            fatalError("Ups!!!")
        }
        summaryLabel = self.contentView.documentReferences!["summaryLabel"] as! UILabel
        insightLabel = self.contentView.documentReferences!["insightLabel"] as! UILabel
        imageView = self.contentView.documentReferences!["imageView"] as! UIView
        button = self.contentView.documentReferences!["button"] as! UIButton
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
            summaryLabel.text = summary
            insightLabel.text = insight
            imageView.backgroundColor = Converter.intToColor(mode)
        }
    }
}

extension Card0CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        shared.translatesAutoresizingMaskIntoConstraints = false
        shared.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        shared.dataSource = dataSource
        
        let width = size.width - shared.margin.left - shared.margin.right
        let measure = shared.contentView.systemLayoutSizeFitting(CGSize(width: width, height: 0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        return measure
    }
}

extension Card0CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard0", ofType: "xml") }
}
