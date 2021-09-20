//
//  GetCocktailsByUsername.swift
//  NETWORKTESTER
//
//  Created by David Todua on 09.09.21.
//

import Foundation

class GetCocktailsByUsername: MyApiRequest<Cocktails> {
    var username: String!
    
    override func apiResource() -> String {
        return "search.php?s="
    }

    override func endPoint() -> String {
        return username
    }
}
