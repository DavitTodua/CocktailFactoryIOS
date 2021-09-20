//
//  GetIngredientById.swift
//  CocktailFactory
//
//  Created by David Todua on 16.09.21.
//

import Foundation

class GetIngredientById: MyApiRequest<Ingredients> {
    
    var ingredientId: String?
    
    override func apiResource() -> String {
        return "lookup.php?iid="
    }

    override func endPoint() -> String {
        return ingredientId ?? "0"
    }
}
