//
//  ReflectionHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class ReflectionHelper {

    class func logBundle(_ bundle: Foundation.Bundle) {
        print(bundle.bundleIdentifier ?? "")
        print(bundle.bundlePath)
    }

    class func logBundleInfo() {
        let main = Foundation.Bundle.main
        logBundle(main)
        let path = main.path(forResource: "CardResources", ofType: "xml")
        print(path ?? "")
        print("------------")
        let apps = Foundation.Bundle.allBundles
        let frameworks = Foundation.Bundle.allFrameworks
        var bundles: [Foundation.Bundle] = []
        bundles.append(contentsOf: apps)
        bundles.append(contentsOf: frameworks)
        for bundle in bundles {
            logBundle(bundle)
        }
    }

    // MARK: Bundle

    static let availiableBundles = Foundation.Bundle.allBundles + Foundation.Bundle.allFrameworks
    static var nameToBundleCache: [String: Foundation.Bundle] = [:]

    public class func findBundleForPath(_ path: String) -> Foundation.Bundle? {
        var best = -1
        var bundle: Foundation.Bundle? = nil

        availiableBundles.forEach { (b) in
            if !b.isLoaded {
                return
            }
            let bundlePath = b.bundlePath
            if path.hasPrefix(bundlePath) {
                let bundlePathLength = bundlePath.characters.count
                if  bundlePathLength > best {
                    best = bundlePathLength
                    bundle = b
                }
            }
        }
        return bundle
    }

    public class func findBundleWithModuleName(_ name: String) -> Foundation.Bundle? {
        if let bundle = nameToBundleCache[name] {
            return bundle
        }
        let suffix = ".\(name)"
        if let bundle = availiableBundles.first(where: { (b) in
            return b.bundleIdentifier?.hasSuffix(suffix) ?? false
        }) {
            nameToBundleCache[name] = bundle
            return bundle
        }
        return nil
    }

    // MARK: Class

    public class func classWithName(_ className: String, bundle: Foundation.Bundle?) -> AnyClass? {
        let bundle = bundle ?? Foundation.Bundle.main
        var classType: AnyClass? = bundle.classNamed(className)
        if classType != nil {
            return classType
        }
        if let module = bundle.infoDictionary?["CFBundleExecutable"] as? String {
            let newName = "\(module).\(className)"
            classType = bundle.classNamed(newName)
        }
        return classType
    }

    class func classWithName_V2(_ className: String, bundle: Foundation.Bundle?) -> AnyClass? {
        let bundle = bundle ?? Foundation.Bundle.main
        var classType: AnyClass? = nil
        // Resolve class within the Bundle for swift modules
        if let module = bundle.infoDictionary?["CFBundleExecutable"] as? String {
            let newName = "\(module).\(className)"
            classType = NSClassFromString(newName)
        }
        if classType != nil {
            return classType
        }
        // Resolve just as className mostly for ObjC
        classType = NSClassFromString(className)
        return classType
    }

    public class func classWithName(_ className: String, bundleIdentifier: String?) -> AnyClass? {
        guard let bundleIdentifier = bundleIdentifier else {
            return classWithName(className, bundle: nil)
        }
        guard let bundle = Foundation.Bundle(identifier: bundleIdentifier) else {
            return nil
        }
        return classWithName(className, bundle: bundle)
    }

    public class func uniqueStringFromClass(_ classType: AnyClass) -> String {
        return "\(String(describing: classType))_\(classType.hash())"
    }

    // MARK: Properties

    public class func setPropertyWithName(_ name: String, value: Any?, instance: NSObject) -> Bool {
        if let value = value {
            if let convertible = value as? NSValueConvertible {
                instance.setValue(convertible.convertToNSValue(), forKey: name)
            } else {
                instance.setValue(value, forKey: name)
            }
        } else {
            instance.setValue(value, forKey: name)
        }
        return true
    }

    public class func setPropertyWithPath(_ path: String, value: Any?, instance: NSObject) -> Bool {
        if let value = value {
            if let convertible = value as? NSValueConvertible {
                instance.setValue(convertible.convertToNSValue(), forKeyPath: path)
            } else {
                instance.setValue(value, forKeyPath: path)
            }
        } else {
            instance.setValue(value, forKeyPath: path)
        }
        return true
    }

    public class func getPropertyWithName(_ name: String, instance: NSObject) -> Any? {
        return instance.value(forKey: name)
    }

    public class func getPropertyWithPath(_ path: String, instance: NSObject) -> Any? {
        return instance.value(forKeyPath: path)
    }

    // MARK: Swizzle

    public class func swizzleMethod(_ classType: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        swizzleMethod(classType, originalSelector: originalSelector, classType, swizzledSelector: swizzledSelector)
    }

    public class func swizzleMethod(_ originalType: AnyClass, originalSelector: Selector, _ swizzledType: AnyClass, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(originalType, originalSelector)
        let swizzledMethod = class_getInstanceMethod(swizzledType, swizzledSelector)

        let didAddMethod = class_addMethod(originalType, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(originalType, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}
