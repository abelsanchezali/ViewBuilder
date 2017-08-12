//
//  PerformanceInspectorViewController.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/26/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

class PerformanceInspectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }

    var fpsLabel: UILabel!

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        fpsLabel = UILabel()
        fpsLabel.font = UIFont.boldSystemFont(ofSize: 9)
        fpsLabel.textColor = UIColor.black
        fpsLabel.text = "-"
        view.addSubview(fpsLabel)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = view.bounds.size
        fpsLabel.frame = CGRect(origin: CGPoint(x: 8, y: 0), size: CGSize(width: 45, height: size.height))
    }

    func setFPSCounter(_ fps: Int) {
        fpsLabel.text = "\(fps) FPS"
    }
}
