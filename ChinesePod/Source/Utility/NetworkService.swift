//
//  NetworkService.swift
//  MoveEasy
//
//  Created by Apple on 17/12/1443 AH.
//

import Foundation

class NetworkService {
    
    var httpUtility: HttpUtility!
    
    static let shared = NetworkService(httpUtility: HttpUtility())
    
    private init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func login(loginRequest: LoginRequestModel, completion: @escaping (_ result: LoginResponseModel?, _ error: String?) -> Void) {
        let url = RestAPI.GetFullUrl(RestAPI.LOGIN_API_1_0_0, version: "1.0.0")
        do {
            let encodedRequest = try JSONEncoder().encode(loginRequest)
            httpUtility.postApiData(url: URL(string: url)!, requestBody: encodedRequest, resultType: LoginResponseModel.self) { result, error  in
                completion(result, error)
            }
        } catch let error {
            debugPrint("Login Request Encoding error : ", error)
            completion(nil, error.localizedDescription)
        }
    }
    
    func getLessons(completion: @escaping (_ result: String?, _ error: String?) -> Void) { // page, count
        var url = RestAPI.GetFullUrl(RestAPI.FETCH_LATEST_LESSONS_API_1_0_0, version: "1.0.0")
        url = url + "?count=10&page=1&sessionid=ca1420bb940bc7534b1c4d6f24d2555a6414eb68c4d272fa3c1fe26659facbd83e" // + (Defaults.authToken ?? "")
        httpUtility.getApiData(url: URL(string: url)!, resultType: String.self) { result, error in
            completion(result, error)
        }
    }
 
}
