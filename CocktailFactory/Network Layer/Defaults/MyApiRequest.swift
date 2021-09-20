//
//  ApiRequest(C).swift
//  NETWORKTESTER
//
//  Created by David Todua on 08.09.21.
//

import Foundation

import SwiftyJSON

class MyApiRequest<ResponseType: Codable> {

    func webserviceUrl() -> String {
        return "https://www.thecocktaildb.com/"
    }

    func apiPath() -> String {
        return "api/json/"
    }

    func apiVersion() -> String {
        return "v1/1/"
    }

    func apiResource() -> String {
        return ""
    }

    func endPoint() -> String {
        return ""
    }

    func bodyParams() -> NSDictionary? {
        return [:]
    }

    func requestType() -> HTTPMethod {
        return .get
    }

    func contentType() -> String {
        return "application/json"
    }
}
