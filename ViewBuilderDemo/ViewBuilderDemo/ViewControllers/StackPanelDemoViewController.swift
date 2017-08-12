//
//  StackPanelDemoViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 8/13/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class StackPanelDemoViewController: UIViewController {

    var stackView: StackPanel!
    @IBOutlet weak var controlTypeSegmentedControl: UISegmentedControl!

    public override func viewDidLoad() {
        super.viewDidLoad()
        stackView = StackPanel()
        view.addSubview(stackView)
        stackView.center = view.center

        stackView.orientation = .vertical
        stackView.padding = UIEdgeInsetsMake(0, 0, 0, 0)
    }

    var index = 0

    func animateStackLayout() {
        UIView.animate(withDuration: 1,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5,
                                   options: [.beginFromCurrentState],
                                   animations: {
                                    let size = self.stackView.sizeThatFits(CGSize(width: 300, height: CGFloat.greatestFiniteMagnitude))
                                    self.stackView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: size.height))
                                    self.stackView.center = self.view.center
                                    self.stackView.setNeedsLayout()
                                    self.stackView.layoutIfNeeded()
            }, completion: nil)
    }

    @IBAction func buttonAction(_ sender: AnyObject) {
        //let margin = UIEdgeInsetsMake(CGFloat(random() % 9 * 5), CGFloat(random() % 9 * 5), CGFloat(random() % 9 * 5), CGFloat(random() % 9 * 5))
        let margin = UIEdgeInsetsMake(0, 0, 0, 0)
        switch controlTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            let button = UIButton(type: .system)
            button.setTitle("Button \(index)", for: UIControlState())
            button.margin = margin
            button.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            stackView.addSubview(button)
        case 1:
            let label = UILabel()
            label.text = "jashdg asjhdg ajshdg jashdg jahsdg jahsgd jahsg dasd."
            label.numberOfLines = 0
            label.margin = margin
            label.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
            stackView.addSubview(label)
        case 2:
            let toggle = UISwitch()
            toggle.margin = margin
            stackView.addSubview(toggle)
        default:
            break
        }

        index += 1
        animateStackLayout()
    }

    var alignment: LayoutAlignment = .center
    @IBAction func alignmentAction(_ sender: AnyObject) {
        switch alignment {
        case .center:
            alignment = .maximum
        case .maximum:
            alignment = .minimum
        case .minimum:
            alignment = .stretch
        case .stretch:
            alignment = .center
        }
        if let button = sender as? UIButton {
            button.setTitle("\(alignment)", for: .normal)
        }
        for child in stackView.subviews {
            child.verticalAlignment = alignment
        }
        animateStackLayout()
    }

    @IBAction func reloadAction(_ sender: AnyObject) {
        //let p = stackView.padding
        //stackView.padding = UIEdgeInsets(top: p.top + 10, left: p.left + 10, bottom: p.bottom + 10, right: p.right + 10)

        for view in stackView.subviews {
            view.isHidden = MathHelper.random() % 2 == 0
            //let p = view.margin
            //view.margin = UIEdgeInsetsMake(CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8)
        }

        animateStackLayout()
        //stackView.setNeedsUpdateConstraints()
        //stackView.updateFocusIfNeeded()
    }


}
