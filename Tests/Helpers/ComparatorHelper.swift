//
//  ComparatorHelper.swift
//  ViewBuilder
//
//  Created by Abel Ernesto Sanchez Ali on 1/19/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

class ComparatorHelper {

    // MARK: UIColor

    class func areEquals(_ first: UIColor?,_ second: UIColor?, threshold: CGFloat = 1.0 / 512) -> Bool {
        guard let a = first, let b = second else {
            return false
        }
        var rA, gA, bA, aA: CGFloat
        rA = 0
        gA = 0
        bA = 0
        aA = 0
        a.getRed(&rA, green: &gA, blue: &bA, alpha: &aA)
        var rB, gB, bB, aB: CGFloat
        rB = 0
        gB = 0
        bB = 0
        aB = 0
        b.getRed(&rB, green: &gB, blue: &bB, alpha: &aB)
        return (abs(rA - rB) < threshold) &&
               (abs(gA - gB) < threshold) &&
               (abs(bA - bB) < threshold) &&
               (abs(aA - aB) < threshold)
    }

    // MARK: UIFont

    class func hasTrait(font: UIFont, traits: CTFontSymbolicTraits) -> Bool {
        let fontTraits = CTFontGetSymbolicTraits(font)
        return fontTraits.contains(traits)
    }
}
