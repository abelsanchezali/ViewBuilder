//
//  AutolayoutTestViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

class AutolayoutTestViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!

    var targetView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //contentView.heightAnchor.constraintEqualToConstant(300).active = true
        //contentView.backgroundColor = UIColor.redColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gestureAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    let autoLayout = false

    @IBAction func createAction(sender: AnyObject) {
        targetView?.removeFromSuperview()
        targetView = nil


        if let path = NSBundle.mainBundle().pathForResource("SampleCard5", ofType: "xml") {
            let x = DocumentBuilder.sharedInstance.loadView(path, options: nil)
            if let view = x {
                targetView = view
                self.view.addSubview(targetView!)

                if autoLayout {
                    targetView!.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint(item: targetView!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
                    NSLayoutConstraint(item: targetView!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0).active = true
                    targetView!.widthAnchor.constraintEqualToConstant(300).active = true
                } else {
                    targetView!.translatesAutoresizingMaskIntoConstraints = true
                    targetView!.center = self.view.center
                }

                animateLayout()

                infoLabel.text = view.hasAmbiguousLayout() ? "Ambiguous" : "OK"

                //print(targetView?.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal))
                //print(targetView?.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))
            }
        }

    }

    @IBAction func testAction(sender: AnyObject) {
        //contentView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        //return
        UIView.transitionWithView(targetView!, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {

            (self.targetView?.documentReferences?["summaryLabel"] as? UILabel)?.text = Lorem.sentences(MathHelper.random() % 8)
            (self.targetView?.documentReferences?["insightLabel"] as? UILabel)?.text = Lorem.sentences(MathHelper.random() % 4)

            }, completion: nil)


        //self.targetView?.setNeedsLayout()
        //self.targetView?.layoutIfNeeded()

        //targetView?.exerciseAmbiguityInLayout()
        animateLayout()
    }

    func animateLayout() {
        guard let targetView = targetView else {
            return
        }
        UIView.animateWithDuration(1,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5,
                                   options: [.BeginFromCurrentState],
                                   animations: {

                                    if !self.autoLayout {
                                        let size = targetView.sizeThatFits(CGSize(width: 300, height: CGFloat.max))
                                        targetView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height))
                                    }

                                    targetView.setNeedsLayout()
                                    targetView.layoutIfNeeded()
            }, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
