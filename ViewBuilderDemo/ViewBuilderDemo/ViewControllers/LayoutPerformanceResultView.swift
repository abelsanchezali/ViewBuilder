//
//  LayoutPerformanceResultView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class LayoutPerformanceResultView: StackPanel {

    weak var titleLabel: UILabel!
    var resultLabels: [UILabel]!

    init() {
        super.init(frame: CGRect.zero)
        self.loadFromDocument(Constants.bundle.path(forResource: "LayoutPerformanceResultView", ofType: "xml")!)
        self.titleLabel = self.documentReferences!["titleLabel"] as! UILabel
        self.resultLabels = [self.documentReferences!["result0Label"] as! UILabel,
                             self.documentReferences!["result1Label"] as! UILabel,
                             self.documentReferences!["result2Label"] as! UILabel]
        resetResults()
    }

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public func resetResults() {
        setResultTime(nil, index: 0)
        setResultTime(nil, index: 1)
        setResultTime(nil, index: 2)
    }

    public func setResultTime(_ duration: Double?, index: Int) {
        guard let duration = duration else {
            resultLabels[index].text = "(none)"
            return
        }

        resultLabels[index].text = NSString(format: "%.2lf seconds", duration) as String
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
