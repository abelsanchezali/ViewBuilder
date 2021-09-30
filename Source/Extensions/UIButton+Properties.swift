//
//  UIButton+Properties.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIButton {

    @objc var titleString: StringForState? {
        set {
            guard let title = newValue else {
                return
            }
            setTitle(title.value, for: title.state)
        }
        get {
            return StringForState(value: self.title(for: self.state), state: self.state);
        }
    }

    @objc var titleAttributed: AttributedForState? {
        set {
            guard let attributed = newValue else {
                return
            }
            setAttributedTitle(attributed.value, for: attributed.state)
        }
        get {
            return AttributedForState(value: self.attributedTitle(for: self.state), state: self.state);
        }
    }

    @objc var titleColor: ColorForState? {
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

    @objc var image: ImageForState? {
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

    @objc var backgroundImage: ImageForState? {
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

    @objc var titleShadowColor: ColorForState? {
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
