//
//  OnboardingDemoViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/29/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class OnboardingDemoViewController: UIViewController {
    weak var continueButton: UIButton!
    weak var infoButton: UIButton!
    weak var bottomView: UIView!
    weak var centerView: UIView!
    weak var topView: UIView!
    weak var headlineLabel: UILabel!
    weak var screenView: OnboardingPhoneScreenView!

    private var isInitialState: Bool = true

    public override func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "OnboardingDemoView", ofType: "xml")!)
        topView = view.documentReferences!["topView"] as! UIView
        headlineLabel = view.documentReferences!["headlineLabel"] as! UILabel
        centerView = view.documentReferences!["centerView"] as! UIView
        bottomView = view.documentReferences!["bottomView"] as! UIView
        continueButton = view.documentReferences!["continueButton"] as! UIButton
        infoButton = view.documentReferences!["infoButton"] as! UIButton
        screenView = view.documentReferences!["screenView"] as! OnboardingPhoneScreenView
        continueButton.addTarget(self, action: #selector(handleContinueAction), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(handleInfoAction), for: .touchUpInside)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        gotoInitialState()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isInitialState {
            isInitialState = false
            AnimationHelper.delayedBlock(1.0, block: {
                self.playBringTitle()
            })
        }
    }

    public override var prefersStatusBarHidden : Bool {
        return true
    }

    func handleContinueAction() {
        navigationController?.popViewController(animated: true)
    }

    func handleInfoAction() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        NavigationHelper.presentDocumentVisualizer(self, path: Constants.bundle.path(forResource: "OnboardingDemoView", ofType: "xml"))
    }
}

extension OnboardingDemoViewController {

    func gotoInitialState() {
        topView.alpha = 0
        topView.verticalAlignment = .center
        headlineLabel.isHidden = true
        headlineLabel.alpha = 0
        bottomView.alpha = 0
        bottomView.layer.transform = CATransform3DMakeTranslation(0, 150, 0)
        centerView.alpha = 0
        centerView.layer.transform = CATransform3DMakeTranslation(0, 400, 0)
        continueButton.alpha = 0
        continueButton.layer.transform = CATransform3DMakeTranslation(0, 24, 0)
        screenView.gotoIntialState()
    }

    func playBringTitle() {
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: {
                                    self.topView.alpha = 1
        }, completion: nil)
        AnimationHelper.delayedBlock(1.0, block: {
            self.topView.verticalAlignment = .minimum
            UIView.animate(withDuration: 1.5,
                delay: 0.0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 0.0,
                options: .beginFromCurrentState,
                animations: {
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }, completion: nil)
        })
        AnimationHelper.delayedBlock(3.25, block: {
            self.headlineLabel.isHidden = false
            UIView.animate(withDuration: 0.5,
                delay: 0,
                options: [.curveEaseOut, .beginFromCurrentState],
                animations: {
                    self.headlineLabel.alpha = 1
                }, completion: nil)
        })

        //

        AnimationHelper.delayedBlock(1.0, block: {
            self.playBringContent()
        })
    }

    func playBringContent() {
        UIView.animate(withDuration: 0.25,
                                   delay: 0,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: {
                                    self.bottomView.alpha = 1
            }, completion: nil)
        UIView.animate(withDuration: 1.0,
                                   delay: 0,
                                   options: .beginFromCurrentState,
                                   animations: {
                                    self.bottomView.layer.transform = CATransform3DIdentity
        }, completion: nil)
        UIView.animate(withDuration: 0.75,
                                   delay: 3.85,
                                   usingSpringWithDamping: 1.0,
                                   initialSpringVelocity: 0.1,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: { 
                                    self.continueButton.alpha = 1
                                    self.continueButton.layer.transform = CATransform3DIdentity
        }, completion: nil)
        UIView.animate(withDuration: 1.0,
                                   delay: 2.0,
                                   usingSpringWithDamping: 1.0,
                                   initialSpringVelocity: 0.1,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: {
                                    self.centerView.alpha = 1
                                    self.centerView.layer.transform = CATransform3DIdentity
            }, completion: { completed in
                if completed {
                    self.screenView.playAnimation()
                }
        })
    }

    
}
