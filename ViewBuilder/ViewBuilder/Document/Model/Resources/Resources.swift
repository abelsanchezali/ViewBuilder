//
//  Resources.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/23/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Resources: NSObject, Sequence {

    public required override init() {

    }

    public required init?(path: String, builder: DocumentBuilder? = nil) {
        let builder = builder ?? DocumentBuilder.shared
        let options = BuildOptions()
        super.init()
        options.instantiation = InstantiationOptions(instance: self)
        guard let _ = builder.loadResources(path, options: options) else {
            Log.shared.write("Could not load resources from path = \(path)")
            return nil
        }
    }

    internal var itemsByName = [String: Item]()


    open func addItem(_ item: Item) {
        itemsByName[item.name] = item
    }

    open func addItems<T: Sequence>(_ items: T) where T.Iterator.Element == Item {
        for item in items {
            addItem(item)
        }
    }

    open func mergeWithResource(_ resource: Resources) {
        addItems(resource)
    }

    open subscript(name: String) -> Any? {
        return itemsByName[name]?.value
    }

    open var count: Int {
        return itemsByName.count
    }

    // MARK: - SequenceType

    open func makeIterator() -> LazyMapIterator<DictionaryIterator<String, Item>, Item> {
        return itemsByName.values.makeIterator()
    }

}

extension Resources: KeyValueResolverProtocol {
    public func resolveValue(for key: String) -> Any? {
        return self[key]
    }
}

// MARK: - CustomStringConvertible

extension Resources {
    open override var description: String {
        get {
            let total = itemsByName.count

            guard total > 0 else {
                return "{Empty}"
            }

            var summary = "{items = \(total)"

            if total > 0 {
                summary += ", names = ("
                var count = 0
                for (name, _) in itemsByName {
                    summary += "\"\(name)\""
                    count += 1
                    if count < total {
                        summary += ", "
                    }
                    if count == 10 {
                        break
                    }
                }
                if count < total {
                    summary += "... and \(total - count) more)"
                } else {
                    summary += ")"
                }
            }

            summary += "}"

            return summary
        }
    }
}
