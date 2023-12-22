//
//  LoginViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 21/12/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var countryContainer: UIView!
    @IBOutlet weak var signupNameContainer: UIView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var selectCountryButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var passwordTextFieldUnderline: UIView!
    @IBOutlet weak var emailTextFieldUnderline: UIView!
    @IBOutlet weak var firstNameTextFieldUnderline: UIView!
    @IBOutlet weak var lastNameTextFieldUnderline: UIView!
    
    var loginViewModel: LoginViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        loadViews()
    }
    
    private func configure() {
        loginViewModel = LoginViewModel()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func loadViews() {
        signupNameContainer.isHidden = true
        countryContainer.isHidden = true
        firstNameLabel.isHidden = true
        firstNameTextField.setPlaceholder(text: "First Name", color: .black)
        firstNameErrorLabel.isHidden = true
        lastNameLabel.isHidden = true
        lastNameTextField.setPlaceholder(text: "Last Name", color: .black)
        lastNameErrorLabel.isHidden = true
        emailLabel.isHidden = true
        emailTextField.setPlaceholder(text: "Email", color: .black)
        emailErrorLabel.text = ""
        passwordLabel.isHidden = true
        passwordTextField.setPlaceholder(text: "Password", color: .black)
        passwordErrorLabel.text = ""
        
        loginButton.rounded()
        
    }
    
    private func textFieldFocused(textField: UITextField) { // animation on focusing on respective textFields
        emailLabel.isHidden = (emailTextField.text?.isEmpty ?? false)
        emailTextField.setPlaceholder(text: "Email")
        emailTextFieldUnderline.backgroundColor = .systemGray2
        passwordLabel.isHidden = (passwordTextField.text?.isEmpty ?? false)
        passwordTextField.setPlaceholder(text: "Password")
        passwordTextFieldUnderline.backgroundColor = .systemGray2
        firstNameLabel.isHidden = firstNameTextField.text?.isEmpty ?? false
        firstNameTextField.setPlaceholder(text: "First Name")
        firstNameTextFieldUnderline.backgroundColor = .systemGray2
        firstNameLabel.isHidden = lastNameTextField.text?.isEmpty ?? false
        lastNameTextField.setPlaceholder(text: "Last Name")
        lastNameTextFieldUnderline.backgroundColor = .systemGray2
        
        if textField == emailTextField {
            if !(textField.text?.isEmpty ?? false) {
                textField.setPlaceholder(text: "Email")
            } else {
                emailLabel.isHidden = false
                textField.setPlaceholder(text: "")
                emailTextFieldUnderline.backgroundColor = .black
            }
        } else if textField == passwordTextField {
            if !(textField.text?.isEmpty ?? false) {
                textField.setPlaceholder(text: "Password")
            } else {
                passwordLabel.isHidden = false
                textField.setPlaceholder(text: "")
                passwordTextFieldUnderline.backgroundColor = .black
            }
        } else if textField == firstNameTextField {
            if !(textField.text?.isEmpty ?? false) {
                textField.setPlaceholder(text: "Password")
            } else {
                firstNameLabel.isHidden = false
                textField.setPlaceholder(text: "")
                firstNameTextFieldUnderline.backgroundColor = .black
            }
        } else if textField == lastNameTextField {
            if !(textField.text?.isEmpty ?? false) {
                textField.setPlaceholder(text: "Password")
            } else {
                lastNameLabel.isHidden = false
                textField.setPlaceholder(text: "")
                lastNameTextFieldUnderline.backgroundColor = .black
            }
        }


        
//        emailLabel.isHidden = (textField != emailTextField && (emailTextField.text?.isEmpty ?? false))
//        passwordLabel.isHidden = (textField != passwordTextField && (passwordTextField.text?.isEmpty ?? false))
    }
    
    @IBAction func selectCountryTapped(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginViewModel?.email = emailTextField.text
        loginViewModel?.password = passwordTextField.text
        loginViewModel?.validate()
        emailErrorLabel.text = loginViewModel?.emailError
        passwordErrorLabel.text = loginViewModel?.passwordError
        firstNameErrorLabel.text = loginViewModel?.firstNameError
        lastNameErrorLabel.text = loginViewModel?.lastNameError
        
        if !(loginViewModel?.proceed ?? false) {
            return
        }
        
        if loginViewModel?.isLoginForm ?? false {
            loginViewModel?.login() { status, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert(title: "Validation", message: error)
                    }
                }
            }
        } else {
            
        }
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        loginViewModel?.isLoginForm = !(loginViewModel?.isLoginForm ?? false)
        UIView.animate(withDuration: 0.5) {
            self.countryContainer.isHidden = !self.countryContainer.isHidden
            self.signupButton.setTitle(self.loginViewModel?.isLoginForm ?? false ? "I don't have an account" : "Log In", for: .normal)
            self.loginButton.setTitle(self.loginViewModel?.isLoginForm ?? false ? "Log In" : "Sign Up", for: .normal)
            self.signupNameContainer.isHidden = !self.signupNameContainer.isHidden
            
//            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }
    
    @IBAction func aboutButtonTapped(_ sender: UIButton) {
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 2.0) {
            self.textFieldFocused(textField: textField)
            self.view.layoutIfNeeded()
        }
    }
}
