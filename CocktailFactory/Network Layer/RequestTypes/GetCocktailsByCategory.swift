//
//  GetCocktailsByCategory.swift
//  CocktailFactory
//
//  Created by David Todua on 10.09.21.
//

import Foundation

class GetCocktailsByCategory: MyApiRequest<Cocktails> {
    var category:String!
    override func apiResource() -> String {
        return "filter.php?c="
    }

    override func endPoint() -> String {
        return category
    }
}
