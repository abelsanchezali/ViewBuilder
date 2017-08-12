//
//  Generator.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public class Generator {

    public static func generateViewModelCollection(_ identifiers: [(String, Int)], count: Int) -> [ViewModel] {
        let total = identifiers.reduce(0) { $0 + $1.1 }
        let range = 0..<count
        let collection: [ViewModel] = range.flatMap { index in
            var k = MathHelper.random() % total
            var id = ""
            for pair in identifiers {
                k -= pair.1
                if k < 0 {
                    id = pair.0
                    break
                }
            }
            return genarateViewModelFor(id)
        }
        return collection
    }

    public static func genarateViewModelFor(_ identifier: String) -> ViewModel? {
        var viewModel: ViewModel? = nil
        switch identifier {
        case Card0CollectionViewCell.reuseIdentifier(),
             Card3CollectionViewCell.reuseIdentifier(),
             Card4CollectionViewCell.reuseIdentifier(),
             Card5CollectionViewCell.reuseIdentifier(),
             Card7CollectionViewCell.reuseIdentifier():
            viewModel = generateViewModelFor_Card0CollectionViewCell()
        case Card1CollectionViewCell.reuseIdentifier():
            viewModel = generateViewModelFor_Card1CollectionViewCell()
        case Cell0CollectionViewCell.reuseIdentifier():
            viewModel = generateViewModelFor_Cell0CollectionViewCell()
        case Card2CollectionViewCell.reuseIdentifier(),
             Card6CollectionViewCell.reuseIdentifier():
            viewModel = generateViewModelFor_Card2CollectionViewCell()
        default: break
        }
        viewModel?["identifier"] = identifier
        return viewModel
    }

    //

    private static let Actions = ["Say Thanks", "Congrats", "Say Hello", "Happy Birthday", "Happy New Year!!!"]

    private static func generateViewModelFor_Card0CollectionViewCell() -> ViewModel {
        let data = ViewModel()
        data["summary"] = Lorem.sentences(3)
        data["insight"] = Lorem.sentences(1)
        data["mode"] = MathHelper.random() % 10
        data["action"] = Actions[MathHelper.random() % Actions.count]
        data["sended"] = false
        return data
    }

    //

    private static func generateViewModelFor_Card1CollectionViewCell() -> ViewModel {
        let data = ViewModel()
        let range = 0..<(3 + MathHelper.random()%50)
        let items = range.map { _ in generateViewModelFor_Cell0CollectionViewCell() }
        data["items"] = items
        return data
    }

    //

    private static let Countries = ["Cuba", "United States", "China", "Brazil", "United Kindom", "Australia", "New Zeland"]

    private static func generateViewModelFor_Cell0CollectionViewCell() -> ViewModel {
        let data = ViewModel()
        data["percentage"] = MathHelper.random() % 101
        data["name"] = Countries[MathHelper.random() % Countries.count]
        return data
    }

    //

    private static let Titles = ["Advertising !Rocks", "We are In", "Profesional Network", "Hulu vs Netflix", "Verizon buys Yahoo"]

    private static func generateViewModelFor_Card2CollectionViewCell() -> ViewModel {
        let data = ViewModel()
        data["title"] = Titles[MathHelper.random() % Titles.count]
        return data
    }

}
