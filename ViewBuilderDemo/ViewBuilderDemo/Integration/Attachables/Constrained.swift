//
//  Constrained.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder

public class Constrained: AttachableProperty, TextDeserializer {

    class Condition {
        let value: Double
        let relation: NSLayoutRelation

        init(value: Double, relation: NSLayoutRelation = .equal) {
            self.value = value
            self.relation = relation
        }
    }

    var conditions = [Condition]()

    // MARK: - AttachableProperty

    public func performAttachment(to instance: Any, name: String) -> Bool {
        guard let view = instance as? UIView else {
            return false
        }
        switch name {
        case "width":
            if conditions.count != 1 {
                Log.shared.write("Warning: Property \"\(name)\" with invalid number of parameters = \(conditions.count).")
                break
            }
            let widthConstraint = NSLayoutConstraint(item: view,
                                                     attribute: .width,
                                                     relatedBy: conditions[0].relation,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: CGFloat(conditions[0].value))
            view.addConstraint(widthConstraint)
        case "height":
            if conditions.count != 1 {
                Log.shared.write("Warning: Property \"\(name)\" with invalid number of parameters = \(conditions.count).")
                break
            }
            let heightConstraint = NSLayoutConstraint(item: view,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: CGFloat(conditions[0].value))
            view.addConstraint(heightConstraint)
            break
        case "size":
            if conditions.count != 2 {
                Log.shared.write("Warning: Property \"\(name)\" with invalid number of parameters = \(conditions.count).")
                break
            }
            let widthConstraint = NSLayoutConstraint(item: view,
                                                     attribute: .width,
                                                     relatedBy: conditions[0].relation,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: CGFloat(conditions[0].value))
            let heightConstraint = NSLayoutConstraint(item: view,
                                                      attribute: .height,
                                                      relatedBy: conditions[1].relation,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: CGFloat(conditions[1].value))
            view.addConstraints([widthConstraint, heightConstraint])
        default:
            // TODO: Log something
            return false
        }
        return true
    }

    // MARK: - TextDeserializer

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text else {
            return nil
        }
        guard let sections = service.parseValidWordsArray(from: text) else {
            return nil
        }
        let instance = Constrained()
        for word in sections {
            guard let condition = parseCondition(word, service: service) else {
                Log.shared.write("Warning: Could not parse Constrained.Condition with text = \"\(word)\".")
                return nil
            }
            instance.conditions.append(condition)
        }
        return instance
    }

    private static func parseCondition(_ word: String, service: TextDeserializerServiceProtocol) -> Condition? {
        var text = word
        var relation: NSLayoutRelation = .equal
        if text.hasSuffix("+") {
            relation = .greaterThanOrEqual
            text = text.substring(to: text.characters.index(before: text.endIndex))
        } else if text.hasSuffix("-") {
            relation = .lessThanOrEqual
            text = text.substring(to: text.characters.index(before: text.endIndex))
        }
        guard let value = Double(text), !value.isNaN else {
            return nil
        }
        return Condition(value: value, relation: relation)
    }
}
