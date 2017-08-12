//
//  AnimationHelper.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public enum TimingFunctionType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case `default`
}

extension TimingFunctionType {
    var mediaTimingFunctionValue: String {
        switch self {
        case .default:
            return kCAMediaTimingFunctionDefault
        case .easeIn:
            return kCAMediaTimingFunctionEaseIn
        case .easeOut:
            return kCAMediaTimingFunctionEaseOut
        case .easeInOut:
            return kCAMediaTimingFunctionEaseInEaseOut
        case .linear:
            return kCAMediaTimingFunctionLinear
        }
    }
}

class AnimationHelper {

    static func delayedBlock(_ delay: TimeInterval, block: @escaping (()->Void)) {
        let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            block()
        }
    }

    static func animateProperty(_ propertyName: String, from: Float, to: Float, duration: Double, timing: TimingFunctionType) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: propertyName)
        animation.timingFunction = CAMediaTimingFunction(name: timing.mediaTimingFunctionValue)
        animation.fromValue = NSNumber(value: from as Float)
        animation.toValue = NSNumber(value: to as Float)
        animation.duration = duration
        return animation
    }

    static func animateProperty(_ propertyName: String, from: CGColor, to: CGColor, duration: Double, timing: TimingFunctionType) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: propertyName)
        animation.timingFunction = CAMediaTimingFunction(name: timing.mediaTimingFunctionValue)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        return animation
    }

    static func animatedPropertyWithKeyframes(_ propertyName: String, keyframes: [Double], values: [NSObject]) -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: propertyName)
        //animation.keyTimes = keyframes.map { NSNumber(double: $0) }
        //animation.values = values
        return animation
    }

    static func animatedSequenced(_ animations: [CAAnimation]) -> CAAnimation {
        // TODO:
        return CAAnimation()
    }

    static func animatedSpawned(_ animations: [CAAnimation]) -> CAAnimation {
        let group = CAAnimationGroup()
        group.animations = animations
        return group
    }
}
