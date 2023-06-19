//
//  AddAddressViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var saveAddressButton: UIButton!
    @IBOutlet weak var addressTitleLabel: UILabel!
    var settingsViewModel: SettingsViewModel!
    var updateAddress: Address!
    var toUpdateAddress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel = SettingsViewModel(netWorkingDataSource: Network())
        setupUI()
        setupDelegation()
        
        if toUpdateAddress{
            addressTitleLabel.text = Constants.addressUpdateTitle
            setUpdatedAddress()
        }
        
        settingsViewModel.bindViewControllerToAddress = { [weak self] in
            if(self?.settingsViewModel.address?.id != nil){
                let alert = Alert().showAlertWithPositiveButtons(title: "", msg: Constants.newAddressMsg, positiveButtonTitle: Constants.ok){_ in
                    self?.dismiss(animated: true)
                }
                self?.present(alert, animated: true)
            }else if self?.settingsViewModel.code == 422 {
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.addressMsg, positiveButtonTitle: Constants.ok, positiveHandler: nil)
                self?.present(alert, animated: true)
            }
        }
        
        settingsViewModel.bindUpdatedAddressToViewController = { [weak self] in
            if(self?.updateAddress.id != nil){
                let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.warning, msg: Constants.updateAddressMsg, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok){_ in
                    self?.dismiss(animated: true)
                }
                self?.present(alert, animated: true)
            }
        }
    }
    
    func setUpdatedAddress(){
        firstNameTextField.text = updateAddress.first_name
        lastNameTextField.text = updateAddress.last_name
        phoneTextField.text = updateAddress.phone
        cityTextField.text = updateAddress.city
        countryTextField.text = updateAddress.country
        addressTextField.text = updateAddress.address1
    }
    
    func setupUI(){
        saveAddressButton.layer.cornerRadius = 12
        setupUIView(uiView: firstNameTextField)
        setupUIView(uiView: lastNameTextField)
        setupUIView(uiView: phoneTextField)
        setupUIView(uiView: cityTextField)
        setupUIView(uiView: countryTextField)
        setupUIView(uiView: addressTextField)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 12
        uiView.layer.borderWidth = 1.0
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.masksToBounds = true
    }
    
    func setupDelegation(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneTextField.delegate = self
        cityTextField.delegate = self
        countryTextField.delegate = self
        addressTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField{
            lastNameTextField.becomeFirstResponder()
        }
        else if textField == lastNameTextField{
            phoneTextField.becomeFirstResponder()
        }
        else if textField == phoneTextField{
            cityTextField.becomeFirstResponder()
        }
        else if textField == cityTextField{
            countryTextField.becomeFirstResponder()
        }
        else if textField == countryTextField{
            addressTextField.becomeFirstResponder()
        }
        else{
            view.endEditing(true)
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAddressButton(_ sender: Any) {
        if(firstNameTextField.text == "" && lastNameTextField.text == "" && cityTextField.text == "" && countryTextField.text == "" && addressTextField.text == "" && phoneTextField.text == "") {
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
        else if(countryTextField.text == "") {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.countryIsEmpty, positiveButtonTitle: Constants.ok, positiveHandler: nil)
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
        else{
            let address = Address(id: nil, customer_id: UserDefault().getCustomerId(), name: "\(self.firstNameTextField.text ?? "") \(self.lastNameTextField.text ?? "")", first_name:firstNameTextField.text ?? "", last_name: lastNameTextField.text ?? "", phone: phoneTextField.text ?? "", address1: self.addressTextField.text ?? "", city: self.cityTextField.text ?? "", country: self.countryTextField.text ?? "", default: false)
            
            let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: address, draftOrder: nil, orders: nil)
            
            let params = JSONCoding().encodeToJson(objectClass: response)
            
            if !toUpdateAddress{
                self.settingsViewModel.postAddress(parameters: params ?? [:])
            }else{
                self.settingsViewModel.putAddress(path: "\(Constants.addressPath)/\(updateAddress.id ?? 0)", parameters: params ?? [:])
            }
        }
    }
}
