//
//  DocumentChildsProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol DocumentChildsProcessor {
    func processDocument(childs: DocumentChildVisitor)
}
