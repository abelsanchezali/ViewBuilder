//
//  PanelBase+UIKitCompatibility.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/19/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension PanelBase {
    @nonobjc static var methodSet = Set<Method>()
    @nonobjc static var patchedSet = Set<Int>()

    public static func patchUIViewClass(_ classType: AnyClass) -> Bool {
        // Check if class was already patched
        let hash = classType.hash()
        if patchedSet.contains(hash) {
            return false
        }
        patchedSet.insert(hash)

        // Check that method was already patched
        let m1 = class_getInstanceMethod(classType, #selector(UIView.invalidateIntrinsicContentSize))
        if m1 == nil || methodSet.contains(m1!) {
            return false
        }
        methodSet.insert(m1!)
        // Get Method implementation
        let imp1 = class_getMethodImplementation(classType, #selector(UIView.invalidateIntrinsicContentSize))
        if imp1 == nil {
            return false
        }

        // Create function that reference current implementation
        typealias Function = @convention(c) (AnyObject) -> Void
        let curriedImplementation = unsafeBitCast(imp1, to: Function.self)

        // Build new implementation block
        let invalidateIntrinsicContentSizeBlock : @convention(block) (UIView!) -> Void = { (_self : UIView!) -> (Void) in
            // Call invalidateMeasure
            _self.invalidateMeasure()
            // Call previous implementation of invalidateIntrinsicContentSize
            curriedImplementation(_self)
        }

        // Create implementation for block
        let imp2 = imp_implementationWithBlock(unsafeBitCast(invalidateIntrinsicContentSizeBlock, to: AnyObject.self))

        // Replace method with new implementation
        method_setImplementation(m1, imp2);

        return true
    }

    // MARK: Initialize

    struct Static {
        static var viewClassesToPatch: [AnyClass] = [UIView.self,
                                                     UIControl.self,
                                                     UILabel.self,
                                                     UIButton.self,
                                                     UISwitch.self,
                                                     UIImageView.self,
                                                     UIInputView.self,
                                                     UIPickerView.self,
                                                     UICollectionReusableView.self,
                                                     UICollectionViewCell.self,
                                                     UIScrollView.self,
                                                     UIVisualEffectView.self,
                                                     UIWebView.self]
    }

    @nonobjc public static let patchedClasses: Int = {
        let count = Static.viewClassesToPatch.reduce(0) { return $0 + (patchUIViewClass($1) ? 1 : 0)}
        return count
    }()

    static let patchClasses: () = {
        // Patching classes for Panel Base Compatibility
        Log.shared.write("PanelBase.Patch total = \(Static.viewClassesToPatch.count), patched = \(PanelBase.patchedClasses)")
    }()
}
