//
//  CollectionViewTestViewControllerCollectionViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

class CollectionViewTestViewControllerCollectionViewController: UIViewController, UICollectionViewControllerInitializationParameter, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CollectionViewCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        collectionView.register(Card0CollectionViewCell.self, forCellWithReuseIdentifier: Card0CollectionViewCell.reuseIdentifier())
        collectionView.register(Card3CollectionViewCell.self, forCellWithReuseIdentifier: Card3CollectionViewCell.reuseIdentifier())
        collectionView.register(Card4CollectionViewCell.self, forCellWithReuseIdentifier: Card4CollectionViewCell.reuseIdentifier())
        collectionView.register(Card5CollectionViewCell.self, forCellWithReuseIdentifier: Card5CollectionViewCell.reuseIdentifier())
        collectionView.register(UINib(nibName: "Card7CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Card7CollectionViewCell.reuseIdentifier())

        collectionView.register(Card1CollectionViewCell.self, forCellWithReuseIdentifier: Card1CollectionViewCell.reuseIdentifier())

        collectionView.register(Card2CollectionViewCell.self, forCellWithReuseIdentifier: Card2CollectionViewCell.reuseIdentifier())
        collectionView.register(Card6CollectionViewCell.self, forCellWithReuseIdentifier: Card6CollectionViewCell.reuseIdentifier())

        addElements(100)
    }

    var array = [ViewModel]()

    func addElements(_ count: Int) {
        var generatorAarray = [(String, Int)]()
        let addAutolayout = (initializationParameter as? String)?.contains("autolayout") == .some(true) ? true : false
        let addCustomlayout = (initializationParameter as? String)?.contains("customlayout") == .some(true) ? true : false
        if addAutolayout {
            generatorAarray.append((Card0CollectionViewCell.reuseIdentifier(), 10))
            generatorAarray.append((Card3CollectionViewCell.reuseIdentifier(), 10))
            generatorAarray.append((Card7CollectionViewCell.reuseIdentifier(), 10))

            generatorAarray.append((Card2CollectionViewCell.reuseIdentifier(), 1))
        }

        generatorAarray.append((Card1CollectionViewCell.reuseIdentifier(), 2))

        if addCustomlayout {
            generatorAarray.append((Card5CollectionViewCell.reuseIdentifier(), 10))

            generatorAarray.append((Card6CollectionViewCell.reuseIdentifier(), 1))
        }

        let elements = Generator.generateViewModelCollection(generatorAarray, count: count)
        array.append(contentsOf: elements)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = array[indexPath.row]
        guard let identifier = viewModel["identifier"] as? String else {
            fatalError("Missing identifier!!!")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let viewModel = array[indexPath.row]
        if let dataSourceReceiver = cell as? DataSourceReceiverProtocol {
            dataSourceReceiver.dataSource = viewModel
        }
        if let cellWithDelegate = cell as? CollectionViewCellWithDelegate {
            cellWithDelegate.delegate = self
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = array[indexPath.row]
        guard let identifier = viewModel["identifier"] as? String else {
            fatalError("Missing identifier!!!")
        }
        switch identifier {
        case Card0CollectionViewCell.reuseIdentifier():
            return Card0CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card1CollectionViewCell.reuseIdentifier():
            return Card1CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card2CollectionViewCell.reuseIdentifier():
            return Card2CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card3CollectionViewCell.reuseIdentifier():
            return Card3CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card4CollectionViewCell.reuseIdentifier():
            return Card4CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card5CollectionViewCell.reuseIdentifier():
            return Card5CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card6CollectionViewCell.reuseIdentifier():
            return Card6CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        case Card7CollectionViewCell.reuseIdentifier():
            return Card7CollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array[indexPath.row])
        default:
            print("sizeForItemAtIndexPath!!!")
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DocumentAssociatedProtocol else {
            return
        }
        NavigationHelper.presentDocumentVisualizer(self, path: cell.associatedDocumentPath)
    }

    // MARK: CollectionViewCellDelegate

    func invalidateCellLayout(_ cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        collectionView.performBatchUpdates({ 
            let ctx = UICollectionViewFlowLayoutInvalidationContext()
            ctx.invalidateItems(at: [indexPath])
            self.collectionView.collectionViewLayout.invalidateLayout(with: ctx)
        }, completion: nil)
    }

    // MARK: - UICollectionViewControllerInitializationParameter

    var initializationParameter: AnyObject?
}

extension CollectionViewTestViewControllerCollectionViewController: Card2CollectionViewCellDelegate {
    func removeCell(_ cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        array.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}
