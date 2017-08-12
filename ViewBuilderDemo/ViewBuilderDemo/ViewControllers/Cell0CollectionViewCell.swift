//
//  Cell0CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class Cell0CollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol, DataSourceReceiverProtocol {

    var colorView: UIView!
    var centerLabel: UILabel!
    var bottomLabel: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.contentView.loadFromDocument(Constants.bundle.path(forResource: "SampleCell0", ofType: "xml")!) {
            fatalError("Ups!!!")
        }
        colorView = self.contentView.documentReferences!["backgroundView"] as! UIView
        centerLabel = self.contentView.documentReferences!["centerLabel"] as! UILabel
        bottomLabel = self.contentView.documentReferences!["bottomLabel"] as! UILabel
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? = nil {
        didSet {
            let dataSource = self.dataSource as? ViewModel
            let percentage = (dataSource?["percentage"] as? Int) ?? 0
            let name = dataSource?["name"] as? String
            centerLabel.text = "\(percentage)%"
            bottomLabel.text = name
        }
    }
}

extension Cell0CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCell0", ofType: "xml") }
}
