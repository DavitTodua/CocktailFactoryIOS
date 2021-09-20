//
//  Cocktails.swift
//  NETWORKTESTER
//
//  Created by David Todua on 09.09.21.
//


import UIKit

// MARK: - Welcome
struct Cocktails: Codable {
    let drinks: [Cocktail]
}

// MARK: - Drink
struct Cocktail: Codable {
    let idDrink, strDrink, strCategory, strIBA: String?
    let strAlcoholic, strGlass, strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10: String?
    let strMeasure1, strMeasure2, strMeasure3: String?
    let strMeasure4, strMeasure5, strMeasure6, strMeasure7: String?
    let strMeasure8, strMeasure9, strMeasure10: String?
    //let strImageAttribution: String?
    
    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strCategory, strIBA
        case strAlcoholic, strGlass, strInstructions
        case strDrinkThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4
        case strIngredient5, strIngredient6, strIngredient7, strIngredient8
        case strIngredient9, strIngredient10
        case strMeasure1, strMeasure2, strMeasure3
        case strMeasure4, strMeasure5, strMeasure6, strMeasure7
        case strMeasure8, strMeasure9, strMeasure10
        
    }
    var image:UIImage? = nil
}
