//
//  PropertyCollection.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/22/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class PropertyCollection: Sequence {

    private var propertiesByName = [String: Property]()

    open func remove(_ property: Property) {
        removeByName(property.name)
    }

    open func removeByName(_ name: String) {
        propertiesByName.removeValue(forKey: name)
    }

    open func removeByNames(_ names: [String]) {
        names.forEach(self.removeByName)
    }

    open func removeAll() {
        propertiesByName.removeAll()
    }

    open subscript(name: String) -> Property? {
        return propertiesByName[name]
    }

    open var count: Int {
        return propertiesByName.count
    }

    open func appendContentsOf<S : Sequence>(_ newElements: S) where S.Iterator.Element == Property {
        for prop in newElements {
            append(prop)
        }
    }

    open func append(_ property: Property) {
        propertiesByName[property.name] = property
    }

  open func makeIterator() -> Dictionary<String, Property>.Values.Iterator {
    return propertiesByName.values.makeIterator();
    }
}
