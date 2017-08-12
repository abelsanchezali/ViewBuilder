//
//  LayoutPerformanceViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/3/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class LayoutPerformanceViewController: UIViewController {

    weak var scrollPanel: ScrollPanel!
    weak var infoLabel: UILabel!
    weak var overviewLabel: UILabel!
    var resultViews: [LayoutPerformanceResultView]!
    var measureCount = 0
    var isMeasuring = false

    override public func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "LayoutPerformanceView", ofType: "xml")!)
        scrollPanel = view.documentReferences!["scrollPanel"] as! ScrollPanel
        infoLabel = view.documentReferences!["infoLabel"] as! UILabel
        overviewLabel = view.documentReferences!["overviewLabel"] as! UILabel
        resultViews = [view.documentReferences!["resultView0"] as! LayoutPerformanceResultView,
                       view.documentReferences!["resultView1"] as! LayoutPerformanceResultView,
                       view.documentReferences!["resultView2"] as! LayoutPerformanceResultView,
                       view.documentReferences!["resultView3"] as! LayoutPerformanceResultView]
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(composeHandler))
        scrollPanel.delegate = self
    }

    func composeHandler() {
        NavigationHelper.presentDocumentVisualizer(self, path: Constants.bundle.path(forResource: "LayoutPerformanceView", ofType: "xml"), completion: nil)
    }

    func startMeasuring() {
        isMeasuring = true
        let alert = UIAlertController(title: "Measuring...", message: nil, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        measureCount += 1
        var times: [Double] = [0, 0, 0, 0]
        AnimationHelper.delayedBlock(0.5) {
            let iterations = [(0, 100), (1, 1000), (2, 3000)]
            print("UIStackView")
            self.resultViews[0].resetResults()
            iterations.forEach({ (iter) in
                times[0] = self.testView(Card3CollectionViewCell(), times: iter.1)
                self.resultViews[0].setResultTime(times[0], index: iter.0)
            })
            AnimationHelper.delayedBlock(0.5, block: {
                print("StackView")
                self.resultViews[1].resetResults()
                iterations.forEach({ (iter) in
                    times[1] = self.testView(Card0CollectionViewCell(), times: iter.1)
                    self.resultViews[1].setResultTime(times[1], index: iter.0)
                })
                AnimationHelper.delayedBlock(0.5, block: {
                    print("AutoLayout+IB")
                    self.resultViews[2].resetResults()
                    iterations.forEach({ (iter) in
                        times[2] = self.testView(Card7CollectionViewCell(), times: iter.1)
                        self.resultViews[2].setResultTime(times[2], index: iter.0)
                    })
                    AnimationHelper.delayedBlock(0.5, block: {
                        print("StackPanel")
                        self.resultViews[3].resetResults()
                        iterations.forEach({ (iter) in
                            times[3] = self.testView(Card5CollectionViewCell(), times: iter.1)
                            self.resultViews[3].setResultTime(times[3], index: iter.0)
                        })
                        let minRatio = min(times[0], times[1], times[2]) / times[3]
                        let maxRatio = max(times[0], times[1], times[2]) / times[3]
                        self.overviewLabel.text = NSString(format: "%.1lfx - %.1lfx", minRatio, maxRatio) as String
                        alert.dismiss(animated: true) {
                            self.scrollPanel.scrollToBottom(true)
                        }
                        self.isMeasuring = false
                    })
                })
            })
        }
    }

    // MARK: - Testing

    let texts = [Lorem.paragraphs(2), Lorem.paragraphs(2), Lorem.paragraphs(2)]

    func testView(_ view: CollectionViewCellProtocol,  times: Int) -> Double {
        var elapsed = 0.0
        for _ in 0..<times {
            let viewModel = Generator.genarateViewModelFor(type(of: view).reuseIdentifier())
            let start = CFAbsoluteTimeGetCurrent()
            _ = type(of: view).measureForFitSize(CGSize(width: 300, height: CGFloat.largeValue), dataSource: viewModel)
            let end = CFAbsoluteTimeGetCurrent()
            elapsed = elapsed + (end - start)
            //print(size)
        }
        print(elapsed)
        return elapsed
    }
}

// MARK: - UIScrollViewDelegate

extension LayoutPerformanceViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isMeasuring {
            return
        }
        if scrollPanel.contentOffset.y < -50 {
            if measureCount > 0 {
                let alert = UIAlertController(title: "Layout Performance", message: "Do you want to make another measurement.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    self.startMeasuring()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                startMeasuring()
            }
        }
    }
}
