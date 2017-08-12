//
//  UIKitStackLayoutViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/3/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class UIKitStackLayoutViewController: UIViewController {
    @IBOutlet weak var controlTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var stackView: UIStackView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
    }

    var index = 0

    func animateStackLayout() {
        UIView.animate(withDuration: 1,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5,
                                   options: [.beginFromCurrentState],
                                   animations: {
                                    self.stackView.setNeedsLayout()
                                    self.stackView.layoutIfNeeded()
            }, completion: nil)
    }

    @IBAction func buttonAction(_ sender: AnyObject) {
        switch controlTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            let button = UIButton(type: .system)
            button.setTitle("Button \(index)", for: UIControlState())
            button.margin = UIEdgeInsetsMake(8, 8, 8, 8)
            button.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            stackView.addArrangedSubview(button)
        case 1:
            let label = UILabel()
            label.text = "jashdg asjhdg ajshdg jashdg jahsdg jahsgd jahsg dasd."
            label.numberOfLines = 0
            label.margin = UIEdgeInsetsMake(8, 8, 8, 8)
            label.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
            stackView.addArrangedSubview(label)
        case 2:
            let toggle = UISwitch()
            toggle.margin = UIEdgeInsetsMake(8, 8, 8, 8)
            stackView.addArrangedSubview(toggle)
        default:
            break
        }

        index += 1
        animateStackLayout()
    }

    @IBAction func alignmentAction(_ sender: AnyObject) {
        switch stackView.alignment {
        case .center:
            stackView.alignment = .fill
        case .fill:
            stackView.alignment = .leading
        case .leading:
            stackView.alignment = .trailing
        case .trailing:
            stackView.alignment = .center
        default:
            break
        }
        if let button = sender as? UIButton {
            button.setTitle("\(stackView.alignment)", for: UIControlState())
        }
    }

    @IBAction func reloadAction(_ sender: AnyObject) {
        for view in stackView.arrangedSubviews {
            view.isHidden = MathHelper.random() % 2 == 0
            //let p = view.margin
            //view.margin = UIEdgeInsetsMake(CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8, CGFloat(random() % 9 * 2) - 8)
        }
        animateStackLayout()

    }

}
