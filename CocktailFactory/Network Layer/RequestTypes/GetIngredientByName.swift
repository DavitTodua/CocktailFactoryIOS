//
//  GetIngredientByName.swift
//  CocktailFactory
//
//  Created by David Todua on 16.09.21.
//

import Foundation

class GetIngredientByName: MyApiRequest<Ingredients> {
    
    var ingredientName: String = ""
    
    override func apiResource() -> String {
        return "search.php?i="
    }

    override func endPoint() -> String {
        return ingredientName
    }
}
