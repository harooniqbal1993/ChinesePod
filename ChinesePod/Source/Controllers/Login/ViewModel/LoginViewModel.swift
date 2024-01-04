//
//  LoginViewModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 21/12/2023.
//

import Foundation

class LoginViewModel {
    
    var isLoginForm: Bool? = true
    var email: String? = nil
    var emailError: String? = nil
    var password: String? = nil
    var passwordError: String? = nil
    var firstName: String? = nil
    var firstNameError: String? = nil
    var lastName: String? = nil
    var lastNameError: String? = nil
    var country: String? = nil
    var proceed: Bool = false
    
    func validate() {
        if email == nil || email?.isEmpty ?? false {
            emailError = "Required"
            proceed = false
        } else {
            if email?.isValidEmail ?? false {
                emailError = nil
                proceed = true
            } else {
                emailError = "Invalid email"
                proceed = false
            }
        }
        
        if password == nil || password?.isEmpty ?? false {
            passwordError = "Required"
            proceed = false
        } else {
            passwordError = nil
            proceed = true
        }
        
        if !(isLoginForm ?? true) {
            if firstName == nil || firstName?.isEmpty ?? false {
                firstNameError = "Required"
                proceed = false
            } else {
                firstNameError = nil
                proceed = true
            }
            
            if lastName == nil || lastName?.isEmpty ?? false {
                lastNameError = "Required"
                proceed = false
            } else {
                lastNameError = nil
                proceed = true
            }
        }
    }
    
    func login(completion: @escaping (Bool, String?) -> Void) {
//        LoginRequestModel(username: "shahzad800422@gmail.com", password: "Ali@123456")
        NetworkService.shared.login(loginRequest: LoginRequestModel(username: email ?? "", password: password ?? "")) { result, error in
//            print(result)
            if let error = error {
                completion(false, error)
                return
            }
            
            if result?.success == 0 {
                completion(false, "Your email or password is incorrect")
                return
            }
            Defaults.authToken = result?.data?.sessionid
            Defaults.isLoggedIn = true
            completion(true, error)
        }
    }
}
