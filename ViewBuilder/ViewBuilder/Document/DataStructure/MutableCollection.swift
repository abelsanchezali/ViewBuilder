//
//  MutableCollection.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/13/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class MutableCollection<T>: NSObject, Sequence, NSCopying {

    typealias U = T

    public override init() {

    }

    public init(elements: [T]) {
        super.init()
        array.append(contentsOf: elements)
    }

    var array = [T]()

    open func append(_ element: T) {
        array.append(element)
    }

    open func append<C : Collection>(contentOf newElements: C) where C.Iterator.Element == T {
        array.append(contentsOf: newElements)
    }

    open func append<S : Sequence>(contentsOf newElements: S) where S.Iterator.Element == T {
        array.append(contentsOf: newElements)
    }

    open func remove(at index: Int) {
        array.remove(at: index)
    }

    open func removeAll() {
        array.removeAll()
    }

    open subscript(index: Int) -> T {
        return array[index]
    }

    open var count: Int {
        return array.count
    }

    open func innerArray() -> [T] {
        return array
    }

    open var last: T? {
        get {
            return array.last
        }
    }

    open var first: T? {
        get {
            return array.first
        }
    }

    // MARK: - SequenceType

    open func makeIterator() -> IndexingIterator<[T]> {
        return array.makeIterator()
    }

    // MARK: - NSCopying

    open func copy(with zone: NSZone?) -> Any {
        let copy = MutableCollection<T>(elements: array)
        return copy
    }
}
