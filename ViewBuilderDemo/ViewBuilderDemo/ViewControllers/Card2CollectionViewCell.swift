//
//  Card2CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/17/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public protocol Card2CollectionViewCellDelegate: CollectionViewCellDelegate {
    func removeCell(_ cell: UICollectionViewCell)
}

public class Card2CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol, CollectionViewCellWithDelegate {

    public weak var delegate: CollectionViewCellDelegate?

    var titleLabel: UILabel!
    var dismissButton: UIButton!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.contentView.loadFromDocument(Constants.bundle.path(forResource: "SampleCard2", ofType: "xml")!) {
            fatalError("Ups!!!")
        }
        dismissButton = self.contentView.documentReferences!["dismissButton"] as! UIButton
        titleLabel = self.contentView.documentReferences!["titleLabel"] as! UILabel

        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }

    func dismissAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.alpha = 0
        }) { (finish) in
            (self.delegate as? Card2CollectionViewCellDelegate)?.removeCell(self)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? = nil {
        didSet {
            let dataSource = self.dataSource as? ViewModel
            titleLabel.text = dataSource?["title"] as? String
        }
    }
}

extension Card2CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        var result = size
        result.width = size.width - 8 - 8
        result.height = 200
        return result
    }
}

extension Card2CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard2", ofType: "xml") }
}
