//
//  MenuScreenViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/10/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

class MenuScreenViewController: UIViewController {
    weak var collectionView: UICollectionView!
    var array: NSMutableArray!
    
    override func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "MenuScreenView", ofType: "xml")!)
        collectionView = view.documentReferences!["collectionView"] as! UICollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(composeHandler))
        if let path = Constants.bundle.path(forResource: "MenuScreens", ofType: "xml") {
            array = DocumentBuilder.shared.loadObject(path) as? NSMutableArray
        } else {
            array = NSMutableArray()
        }
        
        collectionView.register(MenuScreenCollectionViewCell.self, forCellWithReuseIdentifier: MenuScreenCollectionViewCell.reuseIdentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc
    func composeHandler() {
        NavigationHelper.presentDocumentVisualizer(self, path: Constants.bundle.path(forResource: "MenuScreenView", ofType: "xml"), completion: nil)
    }
}

extension MenuScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuScreenCollectionViewCell.reuseIdentifier(), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let viewModel = array[indexPath.row]
        if let dataSourceReceiver = cell as? DataSourceReceiverProtocol {
            dataSourceReceiver.dataSource = viewModel as AnyObject?
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let viewModel = array[indexPath.row] as? ScreenDescriptionModel {
            return viewModel.enabled
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = array[indexPath.row] as? ScreenDescriptionModel,
              let viewController = viewModel.targetViewController() else {
            return
        }
        NavigationHelper.presentViewController(self, targetViewController: viewController)
    }
    
}

extension MenuScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MenuScreenCollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array.object(at: indexPath.row) as AnyObject?)
    }
}
