//
//  ScreenDescriptionModel.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class ScreenDescriptionModel: NSObject {
    @objc public var title: String?
    @objc public var summary: String?
    @objc public var bundleIdentifier: String?
    @objc public var nibName: String?
    @objc public var viewControllerName: String?
    @objc public var storyBoardName: String?
    @objc public var storyBoardIdentifier: String?
    @objc public var parameter: AnyObject?
    @objc public var enabled: Bool = true
}

extension ScreenDescriptionModel {
    public func targetViewController() -> UIViewController? {
        guard let className = viewControllerName, let type = ReflectionHelper.classWithName(className, bundleIdentifier: bundleIdentifier) as? UIViewController.Type
            else {
                return nil
        }
        var viewController: UIViewController? = nil
        if let nibName = nibName {
            viewController = type.init(nibName: nibName, bundle: bundleIdentifier != nil ? Bundle(identifier: bundleIdentifier!) : nil)
        } else if let storyBoardName = storyBoardName, let storyBoardIdentifier = storyBoardIdentifier {
            viewController = UIStoryboard(name: storyBoardName, bundle: bundleIdentifier != nil ? Bundle(identifier: bundleIdentifier!) : nil).instantiateViewController(withIdentifier: storyBoardIdentifier)
        } else {
            viewController = type.init()
        }
        if var parameterInitializedViewController = viewController as? UICollectionViewControllerInitializationParameter {
            parameterInitializedViewController.initializationParameter = parameter
        }
        viewController?.title = title
        return viewController
    }
}
