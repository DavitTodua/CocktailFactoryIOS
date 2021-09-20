//
//  GetRandomCocktail.swift
//  CocktailFactory
//
//  Created by David Todua on 09.09.21.
//

import Foundation

class GetRandomCocktail: MyApiRequest<Cocktails> {
    override func apiResource() -> String {
        return "random.php"
    }
}
