//
//  SignUpViewController.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var signUpViewModel: SignUpViewModel!
    var registered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        signUpViewModel = SignUpViewModel(service: Network())
        signUpViewModel.bindUserToSignUpController = { [weak self] in
            if(self?.signUpViewModel.user?.id != nil){
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.registeredSuccessfully, positiveButtonTitle: Constants.ok){_ in
                    let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                    let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                    home.modalPresentationStyle = .fullScreen
                    self?.present(home, animated: true)
                }
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
                DispatchQueue.main.async {
                    let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.warning, msg: Constants.emailUsedBefore, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok, negativeHandler: nil) { action in
                        let login = self?.storyboard?.instantiateViewController(identifier: Constants.loginIdentifier) as! LoginViewController
                        login.modalPresentationStyle = .fullScreen
                        self?.present(login, animated: true)
                    }
                    self?.present(alert, animated: true)
                }
            } else {
                let addresses = [Address(id: nil, address1: self?.addressTextField.text, city: self?.cityTextField.text, postalCode: self?.postalCodeTextField.text)]
                let user = User(id: nil, firstName: self?.firstNameTextField.text, lastName: self?.lastNameTextField.text, email: self?.emailTextField.text, phone: self?.phoneTextField.text, addresses: addresses, tags: self?.passwordTextField.text)
                
                let params = [
                    "customer": [
                        "first_name":user.firstName,
                        "last_name":user.lastName,
                        "email":user.email,
                        "phone":user.phone,
                        "tags":user.tags,
                        "addresses":[[
                            "zip": user.addresses?[0].postalCode,
                            "city": user.addresses?[0].city,
                            "address1": user.addresses?[0].address1
                        ]]
                    ]
                ]
                self?.signUpViewModel.postUser(parameters: params)
            }
        }
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SignUpUser(_ sender: UIButton) {
        if(firstNameTextField.text == "" && lastNameTextField.text == "" && cityTextField.text == "" && postalCodeTextField.text == "" && addressTextField.text == "" && phoneTextField.text == "" && emailTextField.text == "" && passwordTextField.text == "" && confirmPasswordTextField.text == "") {
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
        else if(cityTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.cityIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(postalCodeTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.postalCodeIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if(addressTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.addressIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
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
            if(passwordTextField.text != confirmPasswordTextField.text){
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.passwordAndConfirmPasswordShouldBeTheSame, positiveButtonTitle: Constants.ok){_ in
                    self.passwordTextField.text = ""
                    self.confirmPasswordTextField.text = ""
                }
                self.present(alert, animated: true)
            }
            else{
                signUpViewModel.getUser()
            }
        }
    }
    
    func setupUI(){
        setupUIView(uiView: firstNameTextField)
        setupUIView(uiView: lastNameTextField)
        setupUIView(uiView: phoneTextField)
        setupUIView(uiView: cityTextField)
        setupUIView(uiView: passwordTextField)
        setupUIView(uiView: confirmPasswordTextField)
        setupUIView(uiView: postalCodeTextField)
        setupUIView(uiView: emailTextField)
        setupUIView(uiView: addressTextField)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 12
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.masksToBounds = true
    }
    
}
