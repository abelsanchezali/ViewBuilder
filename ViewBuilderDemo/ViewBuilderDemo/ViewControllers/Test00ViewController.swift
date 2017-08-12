//
//  Test00ViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 6/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

class Test00ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action1Action(_ sender: AnyObject) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "StackLayoutDemoViewController")
        present(vc, animated: true, completion: nil)
    }

    @IBAction func action2Action(_ sender: AnyObject) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "UIKitStackLayoutViewController")
        present(vc, animated: true, completion: nil)
    }

    @IBAction func action6Action(_ sender: AnyObject) {
        let vc = StackPanelDemoViewController(nibName: "StackPanelDemoViewController", bundle: nil)
        present(vc, animated: true, completion: nil)
    }

    @IBAction func action3Action(_ sender: AnyObject) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "CollectionViewTestViewControllerCollectionViewController")
        present(vc, animated: true, completion: nil)
    }

    @IBAction func action4Action(_ sender: AnyObject) {
    }

    @IBAction func action5Action(_ sender: AnyObject) {
        NavigationHelper.presentLayoutPerformanceScreen(self)
    }

    @IBAction func action0Action(_ sender: AnyObject) {
        PerformanceInspector.start()

        // TODO: Move this code to unit test SVG Path support
        /*
        // Apple Logo
        //let str = "m150.37 130.25c-2.45 5.66-5.35 10.87-8.71 15.66-4.58 6.53-8.33 11.05-11.22 13.56-4.48 4.12-9.28 6.23-14.42 6.35-3.69 0-8.14-1.05-13.32-3.18-5.197-2.12-9.973-3.17-14.34-3.17-4.58 0-9.492 1.05-14.746 3.17-5.262 2.13-9.501 3.24-12.742 3.35-4.929 0.21-9.842-1.96-14.746-6.52-3.13-2.73-7.045-7.41-11.735-14.04-5.032-7.08-9.169-15.29-12.41-24.65-3.471-10.11-5.211-19.9-5.211-29.378 0-10.857 2.346-20.221 7.045-28.068 3.693-6.303 8.606-11.275 14.755-14.925s12.793-5.51 19.948-5.629c3.915 0 9.049 1.211 15.429 3.591 6.362 2.388 10.447 3.599 12.238 3.599 1.339 0 5.877-1.416 13.57-4.239 7.275-2.618 13.415-3.702 18.445-3.275 13.63 1.1 23.87 6.473 30.68 16.153-12.19 7.386-18.22 17.731-18.1 31.002 0.11 10.337 3.86 18.939 11.23 25.769 3.34 3.17 7.07 5.62 11.22 7.36-0.9 2.61-1.85 5.11-2.86 7.51zm-31.26-123.01c0 8.1021-2.96 15.667-8.86 22.669-7.12 8.324-15.732 13.134-25.071 12.375-0.119-0.972-0.188-1.995-0.188-3.07 0-7.778 3.386-16.102 9.399-22.908 3.002-3.446 6.82-6.3113 11.45-8.597 4.62-2.2516 8.99-3.4968 13.1-3.71 0.12 1.0831 0.17 2.1663 0.17 3.2409z"

        // LinkedIn Logo  24x24
        //let str = "M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"

        // iPhone6
        let str = "M0.43,28.195 L0.43,363.208 C0.43,378.239 12.63,390.439 27.661,390.439 L161.13,390.439 C176.161,390.439 188.361,378.239 188.361,363.208 L188.361,28.195 C188.361,13.164 176.161,0.964 161.13,0.964 L27.661,0.964 C12.63,0.964 0.43,13.164 0.43,28.195 L0.43,28.195 Z M10.773,48.986 L10.773,344.369 C10.773,344.887 11.194,345.309 11.712,345.309 L177.791,345.309 C178.309,345.309 178.73,344.887 178.73,344.369 L178.73,48.986 C178.73,48.468 178.309,48.046 177.791,48.046 L11.712,48.046 C11.194,48.046 10.773,48.468 10.773,48.986 L10.773,48.986 ZM82.411,358.446 C86.88,351.631 96.027,349.729 102.843,354.198 C109.658,358.668 111.56,367.815 107.091,374.63 C102.621,381.446 93.474,383.348 86.659,378.878 C79.843,374.409 77.941,365.262 82.411,358.446 L82.411,358.446 Z"
        */

        let autolayout = false

        if let path = Constants.bundle.path(forResource: "DocumentListScreenCollectionViewCell", ofType: "xml") {
            let x: UIView? = DocumentBuilder.shared.load(path, options: nil)
            if let view = x {
                self.view.addSubview(view)
                if autolayout {
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.widthAnchor.constraint(equalToConstant: 250).isActive = true
                    //view.heightAnchor.constraintEqualToConstant(250).active = true
                    //NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 300).active = true
                    NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
                    NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
                } else {
                    let neededSize = view.sizeThatFits(CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude))
                    print(neededSize)
                    let finalSize = CGSize(width: 250, height: neededSize.height)
                    view.bounds = CGRect(origin: CGPoint.zero, size: finalSize)

                    //view.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 200))

                    view.layoutSubviews()
                    view.center = self.view.center
                }
            }
        }
    }
}
