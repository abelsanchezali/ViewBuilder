//
//  ViewIB0.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

class ViewIB0: UIView {

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var switchView: UISwitch!

    @IBAction func handleSwitch(_ sender: AnyObject) {
        if switchView.isOn {
            activityView.startAnimating()
        } else {
            activityView.stopAnimating()
        }
    }

}
