//
//  Card6CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/20/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class Card6CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol, CollectionViewCellWithDelegate {
    
    public weak var delegate: CollectionViewCellDelegate?
    
    var titleLabel: UILabel!
    var dismissButton: UIButton!
    var container: PanelBase!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        container = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "SampleCard6", ofType: "xml")!)
        contentView.addSubview(container)
        ManualLayoutHelper.fitViewInContainer(container, container: contentView)
        
        dismissButton = container.documentReferences!["dismissButton"] as! UIButton
        titleLabel = container.documentReferences!["titleLabel"] as! UILabel
        
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    @objc
    func dismissAction() {
        let width = bounds.size.width
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(translationX: -width, y: 0)
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

extension Card6CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        var result = size
        result.width = size.width - 8 - 8
        result.height = 200
        return result
    }
}

extension Card6CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard6", ofType: "xml") }
}
