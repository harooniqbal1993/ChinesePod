//
//  HttpUtility.swift
//  MovEasyDriver
//
//  Created by Apple on 07/06/1443 AH.
//

import Foundation

struct ImageStore: Encodable {
    var bookingId: Int? = nil
    var image: Data? = nil
}

class HttpUtility {
    
//    let interceptor: Interceptor = Interceptor()
    
    func getApiData<T: Decodable>(url: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: String?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer "+(Defaults.authToken ?? ""), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { responseData, httpUrlResponse, error in
            print("URL : ", url)
            
            if let responseData = responseData {
                let str = String(decoding: responseData, as: UTF8.self)
                print(str)
            }
            
            if let httpResponse = httpUrlResponse as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 401 {
//                    self.interceptor.refreshToken { result, error in
//                        if let error = error {
//                            completionHandler(nil, error)
//                            return
//                        }
//                        print("After refresh Request")
//                        self.getApiData(url: url, resultType: T.self) { result, error in
//                            if let error = error {
//                                completionHandler(nil, error)
//                                return
//                            }
//                            completionHandler(result, error)
//                        }
//                        return
//                    }
                    completionHandler(nil, "Token has expired!")
                }
            }
            
            if error == nil && responseData != nil && responseData?.count != 0 {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(result, nil)
                } catch let error {
                    debugPrint(url)
                    debugPrint("Error occured while decoding : ", error.localizedDescription)
                    completionHandler(nil, error.localizedDescription)
                }
            } else {
                debugPrint("URL: ", url)
                debugPrint("something went wrong : ", error?.localizedDescription ?? "")
                completionHandler(nil, error?.localizedDescription)
            }
        }.resume()
    }
    
    func postApiData<T: Decodable>(url: URL, requestBody: Data, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: String?) -> Void) {
        print("URL: \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        //        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer "+(Defaults.authToken ?? ""), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, httpUrlResponse, error in
            if let data = data {
                let str = String(decoding: data, as: UTF8.self)
                print(str)
            }

            if let apiError = error {
                debugPrint("API ERROR: ", apiError.localizedDescription)
                completionHandler(nil, apiError.localizedDescription)
                return
            }
            
            if let httpResponse = httpUrlResponse as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 401 {
//                    self.interceptor.refreshToken { result, error in
//                        if let error = error {
//                            completionHandler(nil, error)
//                            return
//                        }
//                        print("After refresh Request")
//                        self.postApiData(url: url, requestBody: requestBody, resultType: T.self) { result, error in
//                            if let error = error {
//                                completionHandler(nil, error)
//                                return
//                            }
//                            completionHandler(result, error)
//                        }
//                        return
//                    }
                    completionHandler(nil, "Token has expired!")
                }
            }
            
            if data != nil && data?.count != 0 {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    completionHandler(response, nil)
                } catch let error {
                    debugPrint("POST api error: ", error)
                    completionHandler(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
  
    func postAttachment (fileName: String, imageData: Data, fileKey: String, url: String, completion: @escaping(String?, _ error: String?) -> Void)  {
        let boundary = UUID().uuidString
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let formedUrl = URL(string: url) else { return }
        var request = URLRequest(url: formedUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer "+(Defaults.authToken ?? ""), forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/*\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        session.uploadTask(with: request, from: data, completionHandler: { data, response, error in

            if let checkResponse = response as? HTTPURLResponse {
                if checkResponse.statusCode == 200 {
                    if let json = data {
                        let str = String(decoding: json, as: UTF8.self)
                        print("", str)
                        completion(str, nil)
                    }
                } else if checkResponse.statusCode == 401 {
//                    self.interceptor.refreshToken { result, error in
//                        if let error = error {
//                            completion(nil, error)
//                            return
//                        }
//                        print("After refresh Request")
//                        self.postAttachment(fileName: fileName, imageData: imageData, fileKey: fileKey, url: url) { response, error in
//                            if let error = error {
//                                completion(nil, error)
//                                return
//                            }
//                            completion(response, error)
//                        }
//                        return
//                    }
                    completion(nil, "Token has expired!")
                }
                else {
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                        completion(nil, "Something went wrong")
                        return
                    }
                    let jsonString = String(data: data, encoding: .utf8)!
                    completion(jsonString, nil)
                }
            } else {
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion(nil, nil)
                    return
                }
                completion(nil, nil)
            }
        }).resume()
    }
    
    
    func postWithQueryStringApiData<T: Decodable>(url: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: String?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        //        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer "+(Defaults.authToken ?? ""), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, httpUrlResponse, error in
            print("URL : ", url)
            if let json = data {
                let str = String(decoding: json, as: UTF8.self)
                print("", str)
            }
            if let checkResponse = httpUrlResponse as? HTTPURLResponse {
                if checkResponse.statusCode == 401 {
//                    self.interceptor.refreshToken { result, error in
//                        if let error = error {
//                            completionHandler(nil, error)
//                            return
//                        }
//                        print("After refresh Request")
//                        self.postWithQueryStringApiData(url: url, resultType: resultType) { result, error in
//                            if let error = error {
//                                completionHandler(nil, error)
//                                return
//                            }
//                            completionHandler(result, error)
//                        }
//                        return
//                    }
                    completionHandler(nil, "Token has expired!")
                }
            }
            
            if data != nil && data?.count != 0 {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    completionHandler(response, nil)
                } catch let error {
                    debugPrint("POST api error: ", error)
                    completionHandler(nil, error.localizedDescription)
                }
            }
        }.resume()
    }
}
//
//func postApiData<T: Decodable>(url: URL, requestBody: Data, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: String?) -> Void) {
//    var urlRequest = URLRequest(url: url)
//    urlRequest.httpMethod = "POST"
//    urlRequest.httpBody = requestBody
//    //        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
//    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    urlRequest.addValue("Bearer "+(Defaults.authToken ?? ""), forHTTPHeaderField: "Authorization")
//
//    URLSession.shared.dataTask(with: urlRequest) { data, httpUrlResponse, error in
//        if let data = data {
//            let str = String(decoding: data, as: UTF8.self)
//            print(str)
//        }
//
//        if let apiError = error {
//            debugPrint("API ERROR: ", apiError.localizedDescription)
//            completionHandler(nil, apiError.localizedDescription)
//            return
//        }
//
//        if let httpResponse = httpUrlResponse as? HTTPURLResponse {
//            print("statusCode: \(httpResponse.statusCode)")
//            if httpResponse.statusCode == 401 {
//                completionHandler(nil, "Token has expired!")
//            }
//        }
//
//        if data != nil && data?.count != 0 {
//            do {
//                let response = try JSONDecoder().decode(T.self, from: data!)
//                completionHandler(response, nil)
//            } catch let error {
//                debugPrint("POST api error: ", error)
//                completionHandler(nil, error.localizedDescription)
//            }
//        }
//    }.resume()
//}

//extension Data {
//    mutating func append(_ string: String) {
//        if let data = string.data(using: .utf8) {
//            append(data)
//        }
//    }
//}
//
//
//struct Media {
//    let key: String
//    let fileName: String
//    let data: Data
//    let mimeType: String
//
//    init?(withImage image: UIImage, forKey key: String) {
//        self.key = key
//        self.mimeType = "image/jpg"
//        self.fileName = "\(arc4random()).jpeg"
//
//        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
//        self.data = data
//    }
//}
