//
//  WelcomeScreenViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

class WelcomeScreenViewController: UIViewController {

    static let LogoCenteredSizeToScreenRatio: CGFloat = 0.25
    static let LogoIntitialSizeToScreenRatio: CGFloat = 0.08
    static let LogoCornerRadiusRatio: CGFloat = 0.1
    static let LetersSizeRatio: CGFloat = 0.5

    var logoView: ShapeView!
    var borderView: UIView!
    var infoButton: UIButton!

    var pinchGesture: UIPinchGestureRecognizer!

    override func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "WelcomeScreenView", ofType: "xml")!)
        logoView = view.documentReferences!["logoView"] as! ShapeView
        borderView = view.documentReferences!["borderView"] as! UIView
        infoButton = view.documentReferences!["infoButton"] as! UIButton

        infoButton.addTarget(self, action: #selector(handleInfoTap), for: .touchUpInside)

        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        pinchGesture.isEnabled = false

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        view.addGestureRecognizer(pinchGesture)
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }

    // MARK: - Gestures

    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let size: CGFloat = containerSize * WelcomeScreenViewController.LogoCenteredSizeToScreenRatio * gesture.scale
        setCompleteLogoToSize(size, border: true, letters: true)
        borderView.cornerRadius = Double(size * WelcomeScreenViewController.LogoCornerRadiusRatio)

        if gesture.state == .ended {
            self.gotoCenteredState(1.0, callback: nil)
        }
    }

    func handleTap(_ gesture: UIGestureRecognizer) {
        NavigationHelper.presentMenuScreen(self)
    }

    func handleInfoTap() {
        NavigationHelper.presentMenuScreen(self) { (viewController) in
            NavigationHelper.presentDocumentVisualizer(viewController, path: Constants.bundle.path(forResource: "WelcomeScreenView", ofType: "xml"))
        }
    }

    // MARK: Animation and States

    func setCompleteLogoToSize(_ size: CGFloat, border: Bool, letters: Bool) {
        if border {
            borderView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
            borderView.center = view.center
        }
        if letters {
            logoView.center = view.center
            let bounds = logoView.pathBounds
            logoView.bounds = bounds
            let scale: CGFloat = (size * WelcomeScreenViewController.LetersSizeRatio) / min(bounds.size.width, bounds.size.height)
            logoView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    func gotoInitialState() {
        let size: CGFloat = containerSize * WelcomeScreenViewController.LogoIntitialSizeToScreenRatio
        borderView.frame = view.bounds
        logoView.alpha = 0
        setCompleteLogoToSize(size, border: false, letters: true)
    }

    func gotoCenteredState(_ duration: Double, callback:((_ completed: Bool)->Void)?) {
        let size: CGFloat = containerSize * WelcomeScreenViewController.LogoCenteredSizeToScreenRatio
        let radius = Float(size * WelcomeScreenViewController.LogoCornerRadiusRatio)

        let cornerAnimation = AnimationHelper.animateProperty("cornerRadius",
                                                              from: Float(borderView.cornerRadius),
                                                              to: radius,
                                                              duration: duration,
                                                              timing: .easeOut)
        borderView.cornerRadius = Double(radius)
        borderView.layer.add(cornerAnimation, forKey: "cornerRadius")

        UIView.animate(withDuration: duration,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(duration * 0.5),
                                   initialSpringVelocity: CGFloat(duration * 0.0),
                                   options: .beginFromCurrentState,
                                   animations: {
                                    self.borderView.alpha = 1
                                    self.logoView.alpha = 1
                                    self.setCompleteLogoToSize(size, border: true, letters: true)
        }){ (completed) in
            callback?(completed)
        }
    }

    // MARK: - View

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gotoInitialState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AnimationHelper.delayedBlock(1) {
            self.gotoCenteredState(1.5) { (completed) in
                self.pinchGesture.isEnabled = true
            }
        }
    }

    // MARK: - Helpers

    var containerSize: CGFloat {
        return min(view.bounds.size.width, view.bounds.size.height)
    }
}
