//
//  OnboardingPhoneScreenView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 10/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class OnboardingPhoneScreenView: Panel {
    weak var messageContainer: StackPanel!
    weak var container: UIScrollView!
    init() {
        super.init(frame: CGRect.zero)
        self.loadFromDocument(Constants.bundle.path(forResource: "OnboardingPhoneScreenView", ofType: "xml")!)
        container = self.documentReferences!["container"] as! UIScrollView
        messageContainer = self.documentReferences!["messageContainer"] as! StackPanel
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingPhoneScreenView {
    public func gotoIntialState() {
        messageContainer.subviews.forEach() {
            $0.isHidden = true
            $0.alpha = 0
        }
    }

    public func playAnimation() {
        var index = 0
        func showNextMessage() {
            showMesageIndex(index) { (completed) in
                if completed {
                    index += 1
                    AnimationHelper.delayedBlock(1.0, block: { 
                        showNextMessage()
                    })
                }
            }
        }
        showNextMessage()
    }

    public func showMesageIndex(_ index: Int, comletion: ((Bool) -> Void)?) {
        if index >= messageContainer.subviews.count {
            comletion?(false)
            return
        }
        let subview = messageContainer.subviews[index]
        let delay = Double(subview.tag) / 1000.0
        UIView.animate(withDuration: 0.75,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.1,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: {
                                    subview.isHidden = false
                                    self.layoutIfNeeded()
                                    self.container.scrollToBottom(false)
            }, completion: nil)
        subview.layer.removeAllAnimations()
        subview.transform = CGAffineTransform(translationX: 0, y: 50)
        UIView.animate(withDuration: 0.75,
                                   delay: 0.25,
                                   usingSpringWithDamping: 1.0,
                                   initialSpringVelocity: 0.1,
                                   options: [.curveEaseOut, .beginFromCurrentState],
                                   animations: {
            subview.alpha = 1
            subview.transform = CGAffineTransform.identity
            }, completion: {(completed) in
                if !completed {
                    comletion?(false)
                } else {
                    AnimationHelper.delayedBlock(delay, block: {
                        comletion?(true)
                    })
                }
        })
    }
}
