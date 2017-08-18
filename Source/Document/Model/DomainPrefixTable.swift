//
//  DomainPrefixTable.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class DomainPrefixTable {
    private let domainByPrefix: [String: String]

    public init(table: [String: String]) {
        domainByPrefix = table
    }

    public subscript(prefix: String) -> String? {
        return domainByPrefix[prefix]
    }
}
