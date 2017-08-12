//
//  DataDocument.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

/**
 Model for a document. Constains a valid `Resources` instance if specied in document.
*/
public class DataDocument: NSObject {
    public let builder: DocumentBuilder
    public let options: DocumentOptions

    public let contentNode: DataNode
    public let resourcesNode: DataNode?
    public let baseNode: DataNode

    public lazy var resources: Resources = { [weak self] _ in
        guard let _self = self, let node = _self.resourcesNode else {
            return Resources()
        }
        let root = DataNode(name: Constants.Document.ContentNodeName, domain: Constants.Namespaces.FrameworkNamespace)
        root.childs.append(node)
        guard let resourcesDocument = DataDocument(root: root, builder: _self.builder, options: _self.options) else {
            return Resources()
        }
        let factory = _self.builder.createFactory(resourcesDocument)
        return factory.build() ?? Resources()
    }()

    public required init?(root: DataNode, builder: DocumentBuilder, options: DocumentOptions) {
        self.builder = builder
        self.options = options
        guard root.isContentNode() else {
            Log.shared.write("Error: Invalid root node = \(root)")
            return nil
        }
        self.contentNode = root

        var resourcesNode = contentNode.findResourcesNode()
        var baseNode = contentNode.findFirstNodeDistinct(node: resourcesNode)
        if baseNode == nil {
            baseNode = resourcesNode
            resourcesNode = nil
        }

        guard let base = baseNode else {
            Log.shared.write("Error: Could not find base definition in node = \(root)")
            return nil
        }

        self.baseNode = base
        self.resourcesNode = resourcesNode
        super.init()

        if let resourcesNode = self.resourcesNode {
            resolveNode(resourcesNode)
        }
        resolveNode(self.baseNode)
    }

    @nonobjc private func resolveNode(_ node: DataNode) {
        node.referenceType = ReflectionHelper.classWithName(node.name, bundleIdentifier: node.domain)
        for child in node.childs {
            resolveNode(child)
        }
    }

    @nonobjc private func logCouldNotResolveAttribute(_ attribute: DataAttribute, node: DataNode) {
        if options.verbose {
            Log.shared.write("Warning: Could not resolve attribute = \(attribute) in node = \(node)")
        }
    }
}

fileprivate extension DataNode {

    @nonobjc fileprivate func isContentNode() -> Bool {
        return name == Constants.Document.ContentNodeName && domain == Constants.Namespaces.FrameworkNamespace
    }

    @nonobjc fileprivate func findResourcesNode() -> DataNode? {
        return findChildNodeWithNameAndDomain(Constants.Document.ResourcesNodeName, domain: Constants.Namespaces.FrameworkNamespace)
    }

    @nonobjc func findFirstNodeDistinct(node: DataNode?) -> DataNode? {
        return findChildNodeMatching({ (n) -> Bool in
            return n !== node
        })
    }

}
