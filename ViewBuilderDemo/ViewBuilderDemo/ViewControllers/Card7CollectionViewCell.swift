//
//  Card7CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 10/30/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class Card7CollectionViewCell: UICollectionViewCell, DataSourceReceiverProtocol {
    
    static let shared = UINib(nibName: "Card7CollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card7CollectionViewCell
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var insightLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.margin = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        imageView.cornerRadius = 2.0
        
        contentView.borderWidth = 1
        contentView.borderColor = UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)
        contentView.cornerRadius = 3.0
        contentView.backgroundColor = UIColor.white
        contentView.clipsToBounds = true
        
        button.cornerRadius = 2.0
        button.borderWidth = 1
        button.borderColor = UIColor(red: 6.0 / 255.0, green: 108.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        button.backgroundColor = UIColor.clear
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
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
            button.setTitle(action, for: UIControl.State())
        }
    }
}

extension Card7CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        shared.translatesAutoresizingMaskIntoConstraints = false
        shared.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        shared.dataSource = dataSource
        
        let width = size.width - shared.margin.left - shared.margin.right
        let measure = shared.contentView.systemLayoutSizeFitting(CGSize(width: width, height: 0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        return measure
    }
}
