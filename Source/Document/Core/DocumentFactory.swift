//
//  DocumentFactory.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class DocumentFactory: NSObject {

    static let DomainsValuesPrefix = "domains."
    static let DomainsValuesPrefixLength = DocumentFactory.DomainsValuesPrefix.count

    public let document: DataDocument
    public let builder: DocumentBuilder
    public let options: FactoryOptions

    public required init(document: DataDocument, options: FactoryOptions? = nil) {
        self.document = document
        self.builder = document.builder
        self.options = options ?? FactoryOptions()
    }

    // MARK: Build

    @discardableResult @nonobjc
    internal func buildNode(_ node: DataNode, instance: Any? = nil, symbols: SymbolTable? = nil) -> Any? {
        // Creating symbols if needed
        var owned = false
        var symbolTable = symbols
        if symbolTable == nil {
            owned = true
            symbolTable = SymbolTable()
        }
        
        // Resolve Properties
        let (regularProperties, attachableProperties, domainProperties) = buildPropertiesForNode(node, symbols: symbolTable)

        var instanceObject: Any
        if instance == nil {
            // Resolve reference type
            guard let nodeType = node.referenceType else {
                if options.verbose {
                    Log.shared.write("Could not find type for node = \(node).")
                }
                return nil
            }
            guard let objectConstructor = ConstructorHelper.getConstructorForType(nodeType) else {
                if options.verbose {
                    Log.shared.write("Could not find constructor for node = \(node).")
                }
                return nil
            }
            // Instantiate Object
            guard let obj = instantiateNode(nodeType, properties: regularProperties, constructor: objectConstructor) else {
                if options.verbose {
                    Log.shared.write("Could not create node = \(node).")
                }
                return nil
            }
            instanceObject = obj
        } else {
            instanceObject = instance!
        }

        // Process Properties
        func processProperties(_ properties: PropertyCollection, propertyType: String) {
            let missing = properties.reduce(0, { (count: Int, prop: Property) -> Int in
                let result = applyProperty(instanceObject, property: prop, symbols: symbolTable)
                return count + (result ? 0 : 1)
            })
            if missing > 0 && options.verbose {
                Log.shared.write("Some \(propertyType) properties (\(missing)) were not processed in \(node).")
            }
        }

        processProperties(attachableProperties, propertyType: "attached")
        processProperties(regularProperties, propertyType: "")
        processProperties(domainProperties, propertyType: "domain")

        // Building Childs
        var childs = [Any]()
        for child in node.childs {
            guard let value = buildChild(child, parent: node, parentInstance: instanceObject, symbols: symbolTable) else {
                continue
            }
            // Check if values are transformables
            if let transformable = value as? ObjectTransformable {
                if let values = transformable.transformToObjects() {
                    childs.append(contentsOf: values)
                }
            } else {
                childs.append(value)
            }
        }
        let childVisitor = DocumentChildVisitor(childs: childs)

        // Processing Childs
        if childVisitor.count > 0 {
            if let childProcessor = instanceObject as? DocumentChildsProcessor {
                childProcessor.processDocument(childs: childVisitor)
            } else {
                Log.shared.write("Warning: Type \(type(of: instanceObject)) does not conform to DocumentChildsProcessor protocol")
            }
        }

        // Process Attachables childs
        if childVisitor.count > 0 {
            childVisitor.visit() { (child) -> Bool in
                if let attachable = child as? AttachableObject {
                    if attachable.canBeAttached(to: instanceObject) {
                        attachable.performAttachment(to: instanceObject)
                        return true
                    } else {
                        Log.shared.write("Attachable child = (\(child)) was not compatible with instance = \(instanceObject).")
                    }
                }
                return false
            }
            if childVisitor.count > 0 && options.verbose {
                Log.shared.write("Some childs (\(childVisitor.count)) were not processed in node = \(node).")
            }
        }

        // Adding document references if owned
        if owned {
            if let nsInstance = instanceObject as? NSObject {
                nsInstance.documentReferences = symbolTable?.table
            }
        }
        
        return instanceObject
    }

    // MARK: Constructor

    @nonobjc private func instantiateNode(_ nodeType: AnyClass, properties: PropertyCollection, constructor: ObjectConstructor) -> Any? {
        let parameterKeys = constructor.parametersKeys()
        let parameters = parameterKeys.reduce([String: Any](), { (p, key) -> [String: Any] in
            var r = p
            r[key] = properties[key]?.value
            return r
        })
        properties.removeByNames(parameterKeys)
        guard let obj = constructor.createObject(with: parameters, objectType: nodeType, builder: builder) else {
            return nil
        }
        return obj
    }

    // MARK: Properties

    @nonobjc private func buildPropertiesForNode(_ node: DataNode, symbols: SymbolTable?) -> (PropertyCollection, PropertyCollection, PropertyCollection) {
        let regularCollection = PropertyCollection()
        let attachableCollection = PropertyCollection()
        let domainCollection = PropertyCollection()

        var deserializer: DefaultTextDeserializerService? = nil
        var adapter: TextDeserializerServiceProtocolDelegateAdapter? = nil

        func domainForPrefix(_ prefix: String) -> String? {
            return node.prefixes?[prefix]
        }

        func valueForKey(_ key: String) -> Any? {
            if key.hasPrefix(DocumentFactory.DomainsValuesPrefix) {
                return domainForPrefix(key.substring(from: key.index(key.startIndex, offsetBy: DocumentFactory.DomainsValuesPrefixLength)))
            }
            if let resourceValue = document.resources[key] {
                return resourceValue
            }
            if let symbolValue = symbols?[key] {
                if let valueProvider = symbolValue as? ValueProviderProtocol {
                    if let presentedValue = valueProvider.getPresentedValue() {
                        return presentedValue
                    } else {
                        return nil
                    }
                }
                else {
                    return symbolValue
                }
            }
            return nil
        }

        for attribute in node.attributes {
            var property: Property? = nil
            if let value = attribute.finalValue {
                property = Property(name: attribute.name, hasPath: attribute.hasPath, value: value, domain: attribute.domain)
            } else {
                if deserializer == nil {
                    deserializer = DefaultTextDeserializerService()
                    adapter = TextDeserializerServiceProtocolDelegateAdapter()
                    adapter?.resolveDomainForPrefixBlock = domainForPrefix
                    adapter?.resolveValueForKeyBlock = valueForKey
                    deserializer?.delegate = adapter!
                }
                guard let deserializer = deserializer else {
                    fatalError("Should not happend")
                }
                let (value, mutable) = deserializer.getValueAndMutability(attribute.text)
                if let value = value {
                    property = Property(name: attribute.name, hasPath: attribute.hasPath, value: !(value is NSNull) ? value : nil, domain: attribute.domain)
                    if !mutable {
                        attribute.finalValue = property?.value
                    }
                } else {
                    Log.shared.write("Warning: Could not resolve attribute = \(attribute).")
                    continue
                }
            }
            guard let prop = property else {
                continue
            }
            if prop.domain != nil {
                domainCollection.append(prop)
            } else if prop.value is AttachableProperty {
                attachableCollection.append(prop)
            } else {
                regularCollection.append(prop)
            }
        }
        return (regularCollection, attachableCollection, domainCollection)
    }

    @nonobjc private func applyProperty(_ instance: Any, property: Property, symbols: SymbolTable? = nil) -> Bool {
        // Attachable
        if let attachable = property.value as? AttachableProperty {
            if !attachable.performAttachment(to: instance, name: property.name) {
                Log.shared.write("Warning: Could not attach property \(property.name) in object \(instance).")
                return false
            }
            return true
        }
        // Domain 
        if let domain = property.domain {
            guard domain == Constants.Namespaces.FrameworkNamespace else {
                Log.shared.write("Warning: Domain properties only valid for \(Constants.Namespaces.FrameworkNamespace)")
                return false
            }
            switch property.name {
            case "name":
                guard let name = property.value as? String else {
                    return false
                }
                symbols?[name] = instance
            default:
                return false
            }
            return true
        }
        // Regular
        if !PropertyHelper.setProperty(instance, name: property.name, value: property.value, hasPath: property.hasPath) {
            Log.shared.write("Warning: Could not set property \(property.name) in object \(instance).")
            return false
        }
        return true
    }

    // MARK: Childs

    @nonobjc private func buildChild(_ node: DataNode, parent: DataNode, parentInstance: Any, symbols: SymbolTable?) -> Any? {
        if node.hasPath {
            guard node.referenceType == parent.referenceType else {
                Log.shared.write("Warning: Could not process node \(node). Type does not match parent node \(parent).")
                return nil
            }
            guard let path = node.path, let childInstance = PropertyHelper.getProperty(parentInstance, name: path, hasPath: true) else {
                Log.shared.write("Warning: Could not get property \(String(describing: node.path)) in object \(parentInstance).")
                return nil
            }
            buildNode(node, instance: childInstance, symbols: symbols)
            return nil
        }
        return buildNode(node, instance: nil, symbols: symbols)
    }
}


