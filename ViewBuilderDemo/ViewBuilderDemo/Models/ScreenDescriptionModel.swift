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
    public var title: String?
    public var summary: String?
    public var bundleIdentifier: String?
    public var nibName: String?
    public var viewControllerName: String?
    public var storyBoardName: String?
    public var storyBoardIdentifier: String?
    public var parameter: AnyObject?
    public var enabled: Bool = true
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
