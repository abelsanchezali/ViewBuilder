//
//  LayoutTestScreenViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class LayoutTestScreenViewController: UIViewController {

    weak var actionButton: UIButton!

    override public func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "LayoutTestScreenView", ofType: "xml")!)
        actionButton = view.documentReferences!["actionButton"] as! UIButton
        actionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionHandler)))
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(composeHandler))
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if contentView == nil {
            createContentView()
        }
    }

    var contentView: UIView? = nil

    func createContentView() {
        contentView?.removeFromSuperview()
        if let path = Constants.bundle.path(forResource: "SampleCard5", ofType: "xml") {
            contentView = DocumentBuilder.shared.load(path, options: nil)
            if let subview = contentView {
                subview.verticalAlignment = .center
                subview.horizontalAlignment = .center
                subview.preferredSize = CGSize(width: 300, height: -1)
                view.addSubview(subview)
                view.sendSubview(toBack: subview)
                animateLayout()
            }
        }
    }

    func shuffleContentView() {
        guard let subview = contentView else {
            return
        }
        UIView.transition(with: subview, duration: 0.15, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            (subview.documentReferences?["summaryLabel"] as? UILabel)?.text = Lorem.sentences(MathHelper.random() % 7 + 1)
            (subview.documentReferences?["insightLabel"] as? UILabel)?.text = Lorem.sentences(MathHelper.random() % 4 + 1)
            }, completion: nil)
        animateLayout()
    }

    func animateLayout() {
        UIView.animate(withDuration: 1,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5,
                                   options: [.beginFromCurrentState],
                                   animations: {
                                    self.view.setNeedsLayout()
                                    self.view.layoutIfNeeded()
            }, completion: nil)
    }

    func actionHandler() {
        shuffleContentView()
    }

    func composeHandler() {
        NavigationHelper.presentDocumentVisualizer(self, path: Constants.bundle.path(forResource: "LayoutTestScreenView", ofType: "xml"), completion: nil)
    }
}
