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
    
//    func dashboard(completion: @escaping (_ result: HomeModel?, _ error: String?) -> Void) {
//        let url = "\(baseURL+Constants.EndPoints.dashboard.rawValue)?driverId=\(DriverSession.shared.driver?.id ?? 1125)"
//        httpUtility.getApiData(url: URL(string: url)!, resultType: HomeModel.self) { result, error in
//            completion(result, error)
//        }
//    }
 
}
