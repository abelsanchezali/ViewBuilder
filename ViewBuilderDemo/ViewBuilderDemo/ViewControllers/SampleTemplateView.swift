//
//  SampleTemplateView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 11/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class SampleTemplateView: Panel {
    @objc public weak var topSection: Panel!
    @objc public weak var bottomSection: Panel!

    init() {
        super.init(frame: CGRect.zero)
        self.loadFromDocument(Constants.bundle.path(forResource: "SampleTemplateView", ofType: "xml")!)
        topSection = self.documentReferences!["topSection"] as! Panel
        bottomSection = self.documentReferences!["bottomSection"] as! Panel
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
