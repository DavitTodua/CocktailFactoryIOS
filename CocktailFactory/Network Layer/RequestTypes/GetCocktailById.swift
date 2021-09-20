//
//  GetCocktailByUsername.swift
//  NETWORKTESTER
//
//  Created by David Todua on 08.09.21.
//

import Foundation

class GetCocktailById: MyApiRequest<Cocktails> {

    var cocktailId: String!
 
    override func apiResource() -> String {
        return "lookup.php?i="
    }

    override func endPoint() -> String {
        return cocktailId
    }

//    override func bodyParams() -> NSDictionary? {
//        return ["limit": limit!,
//                "pageNumber": pageNumber!]
//    }

//    override func requestType() -> HTTPMethod {
//        return .get
//    }

}
