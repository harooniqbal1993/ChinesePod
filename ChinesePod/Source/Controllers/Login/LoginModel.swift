//
//  LoginModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 22/12/2023.
//

import Foundation
import CryptoSwift

struct LoginRequestModel: Encodable {
    var username:String?
    var signature:String?
    var client_id:String?
    var client_version:String?
    
    init(username:String, password: String) {
        self.client_id = RestAPI.CLIENT_ID
        self.client_version = SystemInfo.getVersion()
        self.username = username
        self.signature = (RestAPI.CLIENT_SECRET + password).sha256()
    }
}

struct LoginResponseModel: Decodable {
    var success: Int? = 0
    var data: LoginData? = nil
}

struct LoginData: Decodable {
    var sessionid: String? = nil
    var confirm_status: Int? = nil
}
