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
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var addressLine1TextField: UITextField!
    @IBOutlet weak var addressLine2TextField: UITextField!
    @IBOutlet weak var saveAddressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegation()
    }
    
    func setupUI(){
        saveAddressButton.layer.cornerRadius = 12
        setupUIView(uiView: firstNameTextField)
        setupUIView(uiView: lastNameTextField)
        setupUIView(uiView: phoneTextField)
        setupUIView(uiView: cityTextField)
        setupUIView(uiView: zipCodeTextField)
        setupUIView(uiView: addressLine1TextField)
        setupUIView(uiView: addressLine2TextField)
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
        zipCodeTextField.delegate = self
        addressLine1TextField.delegate = self
        addressLine2TextField.delegate = self
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
            zipCodeTextField.becomeFirstResponder()
        }
        else if textField == zipCodeTextField{
            addressLine1TextField.becomeFirstResponder()
        }
        else if textField == addressLine1TextField{
            addressLine2TextField.becomeFirstResponder()
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
}
