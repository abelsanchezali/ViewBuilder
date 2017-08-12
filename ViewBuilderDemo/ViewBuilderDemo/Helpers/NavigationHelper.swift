//
//  NavigationHelper.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/10/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class NavigationHelper {
    public class func presentViewController(_ currentViewController: UIViewController,
                                            targetViewController: UIViewController,
                                            finalViewController: UIViewController? = nil,
                                            animated: Bool = true,
                                            completion: ((_ viewController: UIViewController) -> Void)? = nil) {
        if let navigationController = currentViewController.navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(){
                completion?(finalViewController ?? targetViewController)
            }
            navigationController.pushViewController(targetViewController, animated: animated)
            CATransaction.commit()
        } else {
            currentViewController.present(targetViewController, animated: animated) {
                completion?(finalViewController ?? targetViewController)
            }
        }
    }

    public class func presentMenuScreen(_ currentViewController: UIViewController, completion: ((_ viewController: UIViewController) -> Void)? = nil) {
        let viewController = MenuScreenViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.navigationBar.isTranslucent = false
        navigationViewController.navigationBar.tintColor = Color.deserialize(text: "#0077B5") as! UIColor
        presentViewController(currentViewController, targetViewController: navigationViewController, finalViewController: viewController, animated: true, completion: completion)
    }

    public class func presentDebugStoryBoard(_ currentViewController: UIViewController, completion: ((_ viewController: UIViewController) -> Void)? = nil) {
        presentViewController(currentViewController, targetViewController: UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: completion)
    }

    public class func presentLayoutPerformanceScreen(_ currentViewController: UIViewController, completion: ((_ viewController: UIViewController) -> Void)? = nil) {
        presentViewController(currentViewController, targetViewController: LayoutPerformanceViewController(), animated: true, completion: completion)
    }

    public class func presentDocumentVisualizer(_ currentViewController: UIViewController, path: String?, completion: ((_ viewController: UIViewController) -> Void)? = nil) {
        let viewController = DocumentVisualizerViewController()
        if let path = path {
            viewController.title = NSString(utf8String: path)?.lastPathComponent
            viewController.setContentFromPath(path)
        }
        presentViewController(currentViewController, targetViewController: viewController, animated: true, completion: completion)
    }

}
