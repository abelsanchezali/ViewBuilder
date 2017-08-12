//
//  VectorHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

func +(a:CGPoint, b:CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

func -(a:CGPoint, b:CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

private class SVGPathCommandParser {
    static let CommandsSet = Set<Character>(["m","M","z","Z","l","L","h","H","v","V","c","C","s","S","q","Q","t","T","a","A"])
    static let DigitSet = Set<Character>(["0","1","2","3","4","5","6","7","8","9"])
    static let NullSet = Set<Character>([" ","\t","\r","\n"])
    static let SignSet = Set<Character>(["+","-"])
    static let ExponentialSet = Set<Character>(["e","E"])
    static let Dot: Character = "."
    static let Comma: Character = ","

    let inputString: String
    var currentIndex: String.Index

    init(data: String) {
        inputString = data
        currentIndex = data.startIndex
    }

    private var isEmpty: Bool {
        return currentIndex == inputString.endIndex
    }

    private func readCommandName() -> Character? {
        if isEmpty {
            return nil
        }
        let commandName = inputString[currentIndex]
        if SVGPathCommandParser.CommandsSet.contains(commandName) {
            currentIndex = inputString.index(after: currentIndex)
            return commandName
        } else {
            return nil
        }
    }

    private func readNullCharacters() {
        while !isEmpty {
            let char = inputString[currentIndex]
            if !SVGPathCommandParser.NullSet.contains(char) {
                return
            }
            currentIndex = inputString.index(after: currentIndex)
        }
    }

    private func readSeparator() {
        if isEmpty {
            return
        }
        let char = inputString[currentIndex]
        if char == SVGPathCommandParser.Comma {
            currentIndex = inputString.index(after: currentIndex)
        }
    }

    private func readNumber() -> String? {
        readNullCharacters()
        var allowSign = true
        var allowDot = true
        var allowExponential = false
        var hasDot = false
        var hasExponential = false
        var stop = false
        let firstIndex = currentIndex
        while !isEmpty && !stop {
            let char = inputString[currentIndex]
            switch char {
            case _ where SVGPathCommandParser.SignSet.contains(char):
                if !allowSign {
                    stop = true
                    break
                }
            case _ where SVGPathCommandParser.DigitSet.contains(char):
                allowSign = false
                allowDot = !hasDot && !hasExponential
            case SVGPathCommandParser.Dot:
                if !allowDot {
                    stop = true
                    break
                } else {
                    allowDot = false
                    hasDot = true
                    allowExponential = true
                }
            case _ where SVGPathCommandParser.ExponentialSet.contains(char):
                if !allowExponential {
                    stop = true
                    break
                } else {
                    allowExponential = false
                    hasExponential = true
                    allowSign = true
                }
            default:
                stop = true
                break
            }
            if stop {
                break
            }
            currentIndex = inputString.index(after: currentIndex)
        }
        return inputString.substring(with: firstIndex..<currentIndex)
    }


    func readCommand() -> (Character, [CGFloat])? {
        if isEmpty {
            return nil
        }
        readNullCharacters()
        guard let commandName = readCommandName() else {
            return nil
        }
        var parameters = [CGFloat]()

        while !isEmpty {
            guard let numberString = readNumber() else {
                return nil
            }
            if numberString.isEmpty {
                break
            }
            guard let number = Double(numberString) else {
                return nil
            }
            parameters.append(CGFloat(number))
            readNullCharacters()
            readSeparator()
        }

        return (commandName, parameters)
    }

}

public class VectorHelper {

    public class func getPathFromSVGPathData(data: String?) -> CGPath? {
        guard let data = data else {
            return nil
        }
        let parser = SVGPathCommandParser(data: data)

        let path = UIBezierPath()
        var lastControlPoint: CGPoint? = nil

        func executeClose(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            path.close()
            return true
        }

        func executeMove(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            if parameters.count % 2 != 0 {
                return false
            }
            if parameters.count == 0 {
                return true
            }
            let point = (isRelative ? path.currentPoint : CGPoint.zero) +
                CGPoint(x: parameters[0],
                        y: parameters[1])
            path.move(to: point)
            return executeLine(Array(parameters[2..<parameters.count]), isRelative: isRelative)
        }

        func executeLine(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            if parameters.count % 2 != 0 {
                return false
            }
            let count = parameters.count / 2
            for i in 0..<count {
                let point = (isRelative ? path.currentPoint : CGPoint.zero) +
                    CGPoint(x: parameters[2 * i + 0],
                            y: parameters[2 * i + 1])
                path.addLine(to: point)
            }
            return true
        }

        func executeVertical(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            let count = parameters.count
            for i in 0..<count {
                let originPoint = path.currentPoint
                let point = CGPoint(x: originPoint.x,
                                    y: (isRelative ? originPoint.y : 0) + parameters[i])
                path.addLine(to: point)
            }
            return true
        }

        func executeHorizontal(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            let count = parameters.count
            for i in 0..<count {
                let originPoint = path.currentPoint
                let point = CGPoint(x: (isRelative ? originPoint.x : 0) + parameters[i],
                                    y: originPoint.y)
                path.addLine(to: point)
            }
            return true
        }

        func executeArc(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            if parameters.count % 7 != 0 {
                return false
            }
            let count = parameters.count / 7
            for i in 0..<count {
                let currentPoint = isRelative ? path.currentPoint : CGPoint.zero
                let endPoint = CGPoint(x:parameters[7 * i + 5], y: parameters[7 * i + 6]) + currentPoint
                path.addLine(to: endPoint)
                //path.addCurveToPoint(endPoint, controlPoint1: currentPoint, controlPoint2: currentPoint)
            }
            return true
        }

        func executeQuadraticStart(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            if parameters.count % 4 != 0 {
                return false
            }
            let count = parameters.count / 4
            for i in 0..<count {
                let originPoint = isRelative ? path.currentPoint : CGPoint.zero
                let endPoint = CGPoint(x: parameters[4 * i + 2], y: parameters[4 * i + 3]) + originPoint
                let controlPoint = CGPoint(x: parameters[4 * i + 0], y: parameters[4 * i + 1]) + originPoint
                path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
                lastControlPoint = controlPoint
            }
            return true
        }

        func executeQuadraticContinue(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            if parameters.count % 2 != 0 {
                return false
            }
            let count = parameters.count / 2
            for i in 0..<count {
                let currentPoint = path.currentPoint
                let originPoint = isRelative ? currentPoint : CGPoint.zero
                let endPoint = CGPoint(x: parameters[2 * i + 0], y: parameters[2 * i + 1]) + originPoint

                var controlPoint: CGPoint
                if let lastControlPoint = lastControlPoint {
                    controlPoint = currentPoint + (currentPoint - lastControlPoint)
                } else {
                    controlPoint = path.currentPoint
                }
                path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
                lastControlPoint = controlPoint
            }
            return true
        }

        func executeCubicStart(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            lastControlPoint = nil
            if parameters.count % 6 != 0 {
                return false
            }
            let count = parameters.count / 6
            for i in 0..<count {
                let originPoint = isRelative ? path.currentPoint : CGPoint.zero
                let endPoint = CGPoint(x: parameters[6 * i + 4], y: parameters[6 * i + 5]) + originPoint
                let controlPoint1 = CGPoint(x: parameters[6 * i + 0], y: parameters[6 * i + 1]) + originPoint
                let controlPoint2 = CGPoint(x: parameters[6 * i + 2], y: parameters[6 * i + 3]) + originPoint
                path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                lastControlPoint = controlPoint2
            }
            return true
        }

        func executeCubicContinue(_ parameters: [CGFloat], isRelative: Bool) -> Bool {
            if parameters.count % 4 != 0 {
                return false
            }
            let count = parameters.count / 4
            for i in 0..<count {
                let currentPoint = path.currentPoint
                let originPoint = isRelative ? currentPoint : CGPoint.zero
                let endPoint = CGPoint(x: parameters[4 * i + 2], y: parameters[4 * i + 3]) + originPoint
                let controlPoint2 = CGPoint(x: parameters[4 * i + 0], y: parameters[4 * i + 1]) + originPoint
                var controlPoint1: CGPoint
                if let lastControlPoint = lastControlPoint {
                    controlPoint1 = currentPoint + (currentPoint - lastControlPoint)
                } else {
                    controlPoint1 = path.currentPoint
                }
                path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                lastControlPoint = controlPoint2
            }
            return true
        }

        while let command = parser.readCommand() {
            //print("\(command.0) - \(command.1)")
            var result = false
            switch command.0 {
            case "M":
                result = executeMove(command.1, isRelative: false)
            case "m":
                result = executeMove(command.1, isRelative: true)
            case "L":
                result = executeLine(command.1, isRelative: false)
            case "l": 
                result = executeLine(command.1, isRelative: true)
            case "V":
                result = executeVertical(command.1, isRelative: false)
            case "v":
                result = executeVertical(command.1, isRelative: true)
            case "H":
                result = executeHorizontal(command.1, isRelative: false)
            case "h":
                result = executeHorizontal(command.1, isRelative: true)
            case "A":
                result = executeArc(command.1, isRelative: false)
            case "a":
                result = executeArc(command.1, isRelative: true)
            case "Q":
                result = executeQuadraticStart(command.1, isRelative: false)
            case "q":
                result = executeQuadraticStart(command.1, isRelative: true)
            case "T":
                result = executeQuadraticContinue(command.1, isRelative: false)
            case "t":
                result = executeQuadraticContinue(command.1, isRelative: true)
            case "C":
                result = executeCubicStart(command.1, isRelative: false)
            case "c":
                result = executeCubicStart(command.1, isRelative: true)
            case "S":
                result = executeCubicContinue(command.1, isRelative: false)
            case "s": 
                result = executeCubicContinue(command.1, isRelative: true)
            case "Z":
                result = executeClose(command.1, isRelative: false)
            case "z":
                result = executeClose(command.1, isRelative: true)
            default: break
            }
            if !result {
                return nil
            }
        }
        path.apply(CGAffineTransform.identity)
        return path.cgPath
    }
}
