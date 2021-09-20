//
//  NetworkApiClient.swift
//  NETWORKTESTER
//
//  Created by David Todua on 08.09.21.
//

import UIKit
import Alamofire
import SwiftyJSON

//typealias ResponseHandler = (ApiResponse) -> Void

class MyNetworkApiClient {

    func callApi<ResponseType>(request: MyApiRequest<ResponseType>, responseHandler: @escaping (ApiResponse) -> Void) {

        let completeUrl = request.webserviceUrl() + request.apiPath() +
                    request.apiVersion() + request.apiResource() + request.endPoint()
                
        AF.request(completeUrl).responseData { (response) in
            switch(response.result) {
            case .success:
                let apiResponse = self.successResponse(request: request, response: response)
                responseHandler(apiResponse)
            case .failure:
                print(completeUrl)
                print("couldnt call api")
            }
        }
    }

//    func urlRequestWith<ResponseType>(apiRequest: ApiRequest<ResponseType>) -> URLRequest {
//        let  completeUrl = apiRequest.webserviceUrl() + apiRequest.apiPath() +
//            apiRequest.apiVersion() + apiRequest.apiResource() + apiRequest.endPoint()
//
//        print(completeUrl)
//        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
//        urlRequest.httpMethod = apiRequest.requestType().rawValue
//        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
//        urlRequest.httpBody = try?JSONSerialization.data(withJSONObject:  apiRequest.bodyParams()!, options: [])
//        return urlRequest
//    }

    func successResponse<ResponseType: Codable>(request: MyApiRequest<ResponseType>,
                                     response: DataResponse<Data,AFError>) -> ApiResponse{
        do {
//            let responseJson = try JSON(data: response.data!).object

//            let mydata = try JSONSerialization.data(withJSONObject: responseJson, options: .fragmentsAllowed)
            let decodedValue = try JSONDecoder().decode(ResponseType.self, from: response.data!)
            
            return ApiResponse(success: true, data: decodedValue as AnyObject)
            
        } catch {
            print("Couldnt decode data")
            return ApiResponse(success: false)
        }
    }


}
