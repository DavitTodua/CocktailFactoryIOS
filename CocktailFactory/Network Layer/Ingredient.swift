//
//  Ingredient.swift
//  CocktailFactory
//
//  Created by David Todua on 14.09.21.
//

import Foundation

struct Ingredient: Codable {
    let idIngredient: String
    let strIngredient: String
    let strDescription: String?
    let strType: String?
    let strAlcohol: String?
}
