//
//  AddAddressViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class AddAddressViewController: UIViewController {
    
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
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
