//
//  DocumentVisualizerViewController.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ViewBuilder

public class DocumentVisualizerViewController: UIViewController {

    static let kSymbolsColor = Color.deserialize(text: "#AA0D91") as! UIColor
    static let kClassColor = Color.deserialize(text: "#5C2699") as! UIColor
    static let kPropertiesColor = Color.deserialize(text: "#836C28") as! UIColor
    static let kStringsColor = Color.deserialize(text: "#C41A16") as! UIColor
    static let kNamespacesColor = Color.deserialize(text: "#643820") as! UIColor
    static let kCommentsColor = Color.deserialize(text: "#007400") as! UIColor

    weak var textView: UILabel!

    override public func loadView() {
        view = DocumentBuilder.shared.load(Constants.bundle.path(forResource: "DocumentVisualizerView", ofType: "xml")!)
        textView = view.documentReferences!["textView"] as! UILabel
    }

    public func setContentFromPath(_ path: String) {
        loadViewIfNeeded()
        guard let text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else {
            textView.text = nil
            return
        }
        textView.attributedText = getFormatedXMLAttributedTest(text)
    }

    func getFormatedXMLAttributedTest(_ data: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: data)
        let symbolColor = DocumentVisualizerViewController.kSymbolsColor
        let namespaceColor = DocumentVisualizerViewController.kNamespacesColor
        let keywordsColor = DocumentVisualizerViewController.kPropertiesColor
        let stringsColor = DocumentVisualizerViewController.kStringsColor
        let classColor = DocumentVisualizerViewController.kClassColor
        let commentsColor = DocumentVisualizerViewController.kCommentsColor

        formatAttributedString(attributedString, pattern: "(<)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "(=)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "(\\??>)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "(\\<\\?)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "(/>)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "(\\</)", colors: [symbolColor])
        formatAttributedString(attributedString, pattern: "=\\s*(\"[^\"]*\")", colors: [stringsColor])
        formatAttributedString(attributedString, pattern: " +([\\w]*) *=", colors: [keywordsColor])
        formatAttributedString(attributedString, pattern: " +(\\w+)(:)([\\w\\.]*) *=", colors: [namespaceColor, symbolColor, keywordsColor])
        formatAttributedString(attributedString, pattern: "<\\??/? *(\\w*)[ |>]", colors: [classColor])
        formatAttributedString(attributedString, pattern: "<\\??/? *(\\w+)(:)([\\w\\.]*)[ |>]", colors: [namespaceColor, symbolColor, classColor])
        formatAttributedString(attributedString, pattern: "(<!--((?!-->).)*-->)", colors: [commentsColor])
        return attributedString
    }

    func formatAttributedString(_ attributed: NSMutableAttributedString, pattern: String, colors: [UIColor]) {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive, .dotMatchesLineSeparators]) else {
            return
        }
        attributed.beginEditing()
        regex.enumerateMatches(in: attributed.string,
                                       options: .withoutAnchoringBounds,
                                       range: NSMakeRange(0, attributed.string.characters.count)) { (result, flags, _) in
            guard let result = result else {
                return
            }

            for index in 0..<colors.count {
                let range = result.rangeAt(index + 1)
                attributed.addAttribute(NSForegroundColorAttributeName, value: colors[index], range: range)
            }
        }
        attributed.endEditing()
    }
}
