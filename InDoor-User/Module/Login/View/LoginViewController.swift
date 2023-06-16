//
//  LoginViewController.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginViewModel: LoginViewModel!
    var found = false
    let defaults = UserDefaults.standard
    var customerId: Int? = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loginViewModel = LoginViewModel(service: Network())
        loginViewModel.bindToUsersListSignUpController = { [weak self] in
            if let list = self?.loginViewModel.usersList{
                for user in list {
                    if user.email == self?.emailTextField.text && user.tags == self?.passwordTextField.text {
                        self?.found = true
                        self?.customerId = user.id
                        break
                    }
                }
            }
            
            if self?.found == true {
                DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                        let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                        self?.defaults.setValue(self?.customerId, forKey: Constants.customerId)
                        home.modalPresentationStyle = .fullScreen
                        self?.present(home, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.checkEmailAndPassword, positiveButtonTitle: Constants.ok, positiveHandler: nil)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func login(_ sender: UIButton) {
        if(emailTextField.text == "" && passwordTextField.text == ""){
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.emailAndPasswordCannotBeEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if (emailTextField.text == ""){
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.emailIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else if (passwordTextField.text == ""){
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.passwordIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
            self.present(alert, animated: true)
        }
        else{
            loginViewModel.getUsers()
        }
    }
    func setupUI(){
        setupUIView(uiView: emailTextField)
        setupUIView(uiView: passwordTextField)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 12
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupDelegation(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            emailTextField.becomeFirstResponder()
        }
        else{
            view.endEditing(true)
        }
        
        return true
    }
}
