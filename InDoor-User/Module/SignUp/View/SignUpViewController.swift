//
//  SignUpViewController.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var signUpViewModel: SignUpViewModel!
    var registered = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegation()
        signUpViewModel = SignUpViewModel(service: Network())
        
        signUpViewModel.bindUserToSignUpController = { [weak self] in
            if(self?.signUpViewModel.user?.id != nil){
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.congratulations, msg: Constants.registeredSuccessfully, positiveButtonTitle: Constants.ok){_ in
                    let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                    let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                    self?.defaults.setValue(self?.signUpViewModel.user?.id, forKey: Constants.customerId)
                    self?.defaults.setValue(false, forKey: Constants.isGoogle)
                    home.modalPresentationStyle = .fullScreen
                    self?.present(home, animated: true)
                }
                self?.present(alert, animated: true)
            } else if self?.signUpViewModel.code == 422 {
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.phoneUsedbefore, positiveButtonTitle: Constants.ok, positiveHandler: nil)
                self?.present(alert, animated: true)
            }
        }
        
        signUpViewModel.bindToUsersListSignUpController = { [weak self] in
            if let list = self?.signUpViewModel.usersList{
                for user in list {
                    if user.email == self?.emailTextField.text {
                        self?.registered = true
                        break
                    }
                }
            }
            
            if self?.registered == true {
                self?.registered = false
                let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.warning, msg: Constants.emailUsedBefore, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok, negativeHandler: nil) { action in
                    let login = self?.storyboard?.instantiateViewController(identifier: Constants.loginIdentifier) as! LoginViewController
                    login.modalPresentationStyle = .fullScreen
                    self?.present(login, animated: true)
                }
                self?.present(alert, animated: true)
                
            } else if self?.registered == false {
                let addresses = [Address(id: nil, customer_id: nil, name: "\(self?.firstNameTextField) \(self?.lastNameTextField)", first_name: self?.firstNameTextField.text, last_name: self?.lastNameTextField.text,phone: nil,address1: nil,city: nil, country: self?.phoneTextField.text, default: true)]
                let user = User(id: nil, firstName: self?.firstNameTextField.text, lastName: self?.lastNameTextField.text, email: self?.emailTextField.text, phone: self?.phoneTextField.text, addresses: addresses, tags: self?.passwordTextField.text)
                
                let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: user, customers: nil, addresses: nil, customer_address: nil, orders: nil)
                
                let params = JSONCoding().encodeToJson(objectClass: response)
                self?.signUpViewModel.postUser(parameters: params ?? [:])
            }
        }
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SignUpUser(_ sender: UIButton) {
        if(firstNameTextField.text == "" && lastNameTextField.text == "" && phoneTextField.text == "" && emailTextField.text == "" && passwordTextField.text == "" && confirmPasswordTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.enterAllData, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(firstNameTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.firstNameIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(lastNameTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.lastNameIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(phoneTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.phoneIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(emailTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.emailIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(passwordTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.passwordIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(confirmPasswordTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.confirmPasswordIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else{
            if(isValidPassword(password: passwordTextField.text ?? "") == false){
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.invalidPassword, positiveButtonTitle: Constants.ok){_ in
                    self.passwordTextField.text = ""
                    self.confirmPasswordTextField.text = ""
                }
                self.present(alert, animated: true)
            }
            else if(passwordTextField.text != confirmPasswordTextField.text){
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.passwordAndConfirmPasswordShouldBeTheSame, positiveButtonTitle: Constants.ok){_ in
                    self.passwordTextField.text = ""
                    self.confirmPasswordTextField.text = ""
                }
                self.present(alert, animated: true)
            }
            else{
                signUpViewModel.getUsers()
            }
        }
    }
    
    func setupUI(){
        setupUIView(uiView: firstNameTextField)
        setupUIView(uiView: lastNameTextField)
        setupUIView(uiView: phoneTextField)
        setupUIView(uiView: passwordTextField)
        setupUIView(uiView: confirmPasswordTextField)
        setupUIView(uiView: emailTextField)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 12
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.masksToBounds = true
    }
    
    func isValidPassword(password: String) -> Bool{
        let passwordRegex = NSPredicate(format: Constants.passwordFormat, Constants.passwordRegEx)
        return passwordRegex.evaluate(with: password)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupDelegation(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField{
            firstNameTextField.becomeFirstResponder()
        }
        else if textField == lastNameTextField{
            lastNameTextField.becomeFirstResponder()
        }
        else if textField == phoneTextField{
            phoneTextField.becomeFirstResponder()
        }
        else if textField == emailTextField{
            emailTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField{
            passwordTextField.becomeFirstResponder()
        }
        else{
            view.endEditing(true)
        }
        
        return true
    }
}
