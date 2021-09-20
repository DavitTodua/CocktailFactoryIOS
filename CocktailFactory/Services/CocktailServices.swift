//
//  CocktailServices.swift
//  NETWORKTESTER
//
//  Created by David Todua on 09.09.21.
//

import Foundation

class CocktailServices {
    
    typealias CompletionHandler =  (Bool, AnyObject?) -> Void
    
    func fetchCocktailById(id: String, completion: @escaping CompletionHandler) {
        let request = GetCocktailById()
        request.cocktailId = id
        MyNetworkApiClient().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            } else {
                completion(false, apiResponse.message as AnyObject?)
            }
        }
    }
    
    func fetchCocktailsByUsername(username:String, completion:@escaping CompletionHandler) {
        let request = GetCocktailsByUsername()
        request.username = username
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }
    
    func getRandomCocktail(completion: @escaping CompletionHandler) {
        let request = GetRandomCocktail()
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }
    
    func getCocktailsByCategory(givenCategory:String, completion: @escaping CompletionHandler) {
        let request = GetCocktailsByCategory()
        request.category = givenCategory
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }
    
    func getIngredientsByName(ingredientName:String, completion: @escaping CompletionHandler) {
        let request = GetIngredientByName()
        request.ingredientName = ingredientName.lowercased()
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }
    func getIngredientsById(ingredientId:String, completion: @escaping CompletionHandler) {
        let request = GetIngredientById()
        request.ingredientId = ingredientId
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }
    
    func getCocktailsByIngredient(ingredientName:String, completion: @escaping CompletionHandler) {
        let request = GetCocktailsByIngredient()
        request.ingredientName = ingredientName
        MyNetworkApiClient.init().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.data)
            }
        }
    }

}
