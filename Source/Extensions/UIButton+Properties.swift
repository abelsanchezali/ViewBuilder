//
//  UIButton+Properties.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIButton {
    public var title: StringForState? {
        set {
            guard let title = newValue else {
                return
            }
            setTitle(title.value, for: title.state)
        }
        get {
            return nil
        }
    }

    public var attributedTittle: AttributedForState? {
        set {
            guard let attributed = newValue else {
                return
            }
            setAttributedTitle(attributed.value, for: attributed.state)
        }
        get {
            return nil
        }
    }

    public var titleColor: ColorForState? {
        set {
            guard let color = newValue else {
                return
            }
            setTitleColor(color.value, for: color.state)
        }
        get {
            return nil
        }
    }

    public var image: ImageForState? {
        set {
            guard let image = newValue else {
                return
            }
            setImage(image.value, for: image.state)
        }
        get {
            return nil
        }
    }

    public var backgroundImage: ImageForState? {
        set {
            guard let image = newValue else {
                return
            }
            setBackgroundImage(image.value, for: image.state)
        }
        get {
            return nil
        }
    }

    public var titleShadowColor: ColorForState? {
        set {
            guard let color = newValue else {
                return
            }
            setTitleShadowColor(color.value, for: color.state)
        }
        get {
            return nil
        }
    }


}
