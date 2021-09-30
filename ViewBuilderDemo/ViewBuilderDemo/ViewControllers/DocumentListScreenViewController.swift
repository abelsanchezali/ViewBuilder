//
//  DocumentListScreenViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 10/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class DocumentListScreenViewController: UIViewController {
    weak var collectionView: UICollectionView!
    var array: NSMutableArray!
    
    public override func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "DocumentListScreenView", ofType: "xml")!)
        collectionView = view.documentReferences!["collectionView"] as! UICollectionView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadDocumentList()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(composeHandler))
        collectionView.register(DocumentListScreenCollectionViewCell.self, forCellWithReuseIdentifier: DocumentListScreenCollectionViewCell.reuseIdentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func loadDocumentList(_ fromDocument: Bool = false) {
        if fromDocument {
            if let path = Constants.bundle.path(forResource: "DocumentList", ofType: "xml") {
                array = DocumentBuilder.shared.load(path)
            } else {
                array = NSMutableArray()
            }
        } else {
            array = NSMutableArray(array: Constants.bundle.paths(forResourcesOfType: "xml", inDirectory: nil, forLocalization: nil).map { (path) -> DocumentModel in
                let model = DocumentModel()
                model.bundleIdentifier = Constants.bundle.bundleIdentifier
                model.name = NSString(utf8String: path)?.lastPathComponent
                return model
            })
        }
    }
    
    @objc
    func composeHandler() {
        NavigationHelper.presentDocumentVisualizer(self, path: Constants.bundle.path(forResource: "DocumentListScreenView", ofType: "xml"), completion: nil)
    }
    
}

extension DocumentListScreenViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentListScreenCollectionViewCell.reuseIdentifier(), for: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let viewModel = array[indexPath.row]
        if let dataSourceReceiver = cell as? DocumentListScreenCollectionViewCell {
            dataSourceReceiver.dataSource = viewModel as AnyObject?
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = array[indexPath.row] as? DocumentModel, let path = viewModel.documentPath() else {
            return
        }
        NavigationHelper.presentDocumentVisualizer(self, path: path)                  
    }
    
}

extension DocumentListScreenViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DocumentListScreenCollectionViewCell.measureForFitSize(CGSize(width: collectionView.bounds.width, height: -1), dataSource: array.object(at: indexPath.row) as AnyObject?)
    }
}
