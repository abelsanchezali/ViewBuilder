//
//  Card0CollectionViewCell.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class Card1CollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DataSourceReceiverProtocol {
    var collectionView: UICollectionView!
    var items = [ViewModel]()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.contentView.loadFromDocument(Constants.bundle.path(forResource: "SampleCard1", ofType: "xml")!) {
            fatalError("Ups!!!")
        }
        collectionView = self.contentView.documentReferences!["collectionView"] as! UICollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        collectionView.register(Cell0CollectionViewCell.self, forCellWithReuseIdentifier: Cell0CollectionViewCell.reuseIdentifier())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var dataSource: AnyObject? {
        didSet {
            let dataSource = self.dataSource as? ViewModel
            let newItems = dataSource?["items"] as? [ViewModel] ?? []
            let contentOffset = dataSource?["contentOffset"] as? CGPoint ?? CGPoint(x: -self.collectionView.contentInset.left, y: 0)
            collectionView.contentOffset = contentOffset
            OperationQueue.main.addOperation {
                self.items = newItems
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell0CollectionViewCell.reuseIdentifier(), for: indexPath)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let viewModel = items[indexPath.row]
        if let dataSourceReceiver = cell as? DataSourceReceiverProtocol {
            dataSourceReceiver.dataSource = viewModel
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: bounds.height)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       let dataSource = self.dataSource as? ViewModel
       dataSource?["contentOffset"] = self.collectionView.contentOffset
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dataSource = self.dataSource as? ViewModel
        dataSource?["contentOffset"] = self.collectionView.contentOffset
    }

}

extension Card1CollectionViewCell: CollectionViewCellProtocol {
    public static func measureForFitSize(_ size: CGSize, dataSource: AnyObject?) -> CGSize {
        var result = size
        result.height = 90
        return result
    }
}

extension Card1CollectionViewCell: DocumentAssociatedProtocol {
    public var associatedDocumentPath: String? { return Constants.bundle.path(forResource: "SampleCard1", ofType: "xml") }
}
