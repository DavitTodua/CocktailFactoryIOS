//
//  GetCocktailsByIngredient.swift
//  CocktailFactory
//
//  Created by David Todua on 16.09.21.
//

import Foundation
class GetCocktailsByIngredient: MyApiRequest<Cocktails> {
    
    var ingredientName: String?
    
    override func apiResource() -> String {
        return "filter.php?i="
    }

    override func endPoint() -> String {
        return ingredientName?.lowercased() ?? "gin"
    }
}
