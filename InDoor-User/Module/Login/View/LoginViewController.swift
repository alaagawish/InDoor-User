//
//  LoginViewController.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginViewModel: LoginViewModel!
    var found = false
    let defaults = UserDefaults.standard
    var customerId: Int? = 0
    var isGoogle = false
    var user: User!
    var favoritesViewModel: FavoritesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        favoritesViewModel = FavoritesViewModel(service: DatabaseManager.instance, network: Network())
        favoritesViewModel.bindGetfavoriteDraftOrderToController = {[weak self] in
            guard let lineItemsList = self?.favoritesViewModel.getFavoriteDraftOrder?.lineItems else {return}
            let list = lineItemsList.filter{$0.title != "dummy"}
            print("list:\(list)")
            for item in list {
                let localProduct = LocalProduct(id: item.id!, customer_id: (self?.defaults.integer(forKey: Constants.customerId))!, title: item.title!, price: item.price!, image: item.properties![0].value!)
                print("Local Product: \(localProduct)")
                self?.favoritesViewModel.addProduct(product: localProduct)
            }
        }
        loginViewModel = LoginViewModel(service: Network())
        loginViewModel.bindUserToLoginController = { [weak self] in
            if(self?.loginViewModel.user?.id != nil){
                self?.getFavoritesDraftOrderFromRemoteToLocal()
                self?.getFavoritesDraftOrderFromRemoteToLocal()
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.congratulations, msg: Constants.registeredSuccessfully, positiveButtonTitle: Constants.ok){_ in
                    let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                    let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                    self?.defaults.setValue(self?.loginViewModel.user?.id, forKey: Constants.customerId)
                    self?.defaults.setValue(self?.isGoogle, forKey: Constants.isGoogle)
                    home.modalPresentationStyle = .fullScreen
                    self?.present(home, animated: true)
                }
                self?.present(alert, animated: true)
            }
        }
        loginViewModel.bindToUsersListLoginController = { [weak self] in
            if self?.isGoogle == false {
                if let list = self?.loginViewModel.usersList{
                    for user in list {
                        if user.email == self?.emailTextField.text && user.tags == self?.passwordTextField.text {
                            self?.found = true
                            self?.customerId = user.id
                            self?.defaults.setValue(self?.customerId, forKey: Constants.customerId)
                            let splitNote = user.note?.components(separatedBy: ",")
                            self?.defaults.set(splitNote?[1], forKey: Constants.cartId)
                            self?.defaults.set(splitNote?[0], forKey: Constants.favoritesId)
                            self?.getFavoritesDraftOrderFromRemoteToLocal()
                            break
                        }
                    }
                }
                
                if self?.found == true {
                    
                    print("customerId: \(self?.defaults.integer(forKey: Constants.customerId))")
                    print("favId: \(self?.defaults.string(forKey: Constants.favoritesId))")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                        let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                        self?.defaults.setValue(self?.customerId, forKey: Constants.customerId)
                        self?.defaults.setValue(self?.isGoogle, forKey: Constants.isGoogle)
                        home.modalPresentationStyle = .fullScreen
                        self?.present(home, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.checkEmailAndPassword, positiveButtonTitle: Constants.ok, positiveHandler: nil)
                        self?.present(alert, animated: true)
                    }
                }
            } else {
                if let list = self?.loginViewModel.usersList{
                    for user in list {
                        if user.email == self?.user.email {
                            self?.found = true
                            self?.defaults.setValue(self?.customerId, forKey: Constants.customerId)
                            self?.getFavoritesDraftOrderFromRemoteToLocal()
                            break
                        }
                    }
                }
                
                if self?.found == true {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                        let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                        //self?.defaults.setValue(self?.customerId, forKey: Constants.customerId)
                        self?.defaults.setValue(self?.isGoogle, forKey: Constants.isGoogle)
                        home.modalPresentationStyle = .fullScreen
                        self?.present(home, animated: true)
                    }
                } else {
                    let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: self?.user, customers: nil, addresses: nil, customer_address: nil, draftOrder: nil, orders: nil,order: nil)
                    
                    let params = JSONCoding().encodeToJson(objectClass: response)
                    self?.loginViewModel.postUser(parameters: params ?? [:])
                }
            }
        }
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
       
    }
    
    @IBAction func login(_ sender: UIButton) {
        isGoogle = false
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
    
    @IBAction func loginWithGoogle(_ sender: UIButton) {
        isGoogle = true
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {[weak self] signInResult, error in
            guard error == nil else { return }
            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) {[weak self] result, error in
                self?.user = User(id: nil, firstName: signInResult?.user.profile?.givenName ,lastName: signInResult?.user.profile?.familyName, email: signInResult?.user.profile?.email, phone: nil, addresses: nil, tags: nil)
                self?.loginViewModel.getUsers()
            }
        }
    }
    func getFavoritesDraftOrderFromRemoteToLocal(){
        self.favoritesViewModel.removeAllProduct()
        self.favoritesViewModel.getFavoriteDraftOrderFromAPI()
    }
}
