//
//  SettingsViewController.swift
//  InDoor-User
//
//  Created by Mac on 03/06/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var connectToUsView: UIView!
    @IBOutlet weak var aboutInDoorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGesture()
    }
    
    func setupUI(){
        logoutButton.layer.cornerRadius = 12
        setupUIView(uiView: addressView)
        setupUIView(uiView: currencyView)
        setupUIView(uiView: connectToUsView)
        setupUIView(uiView: aboutInDoorView)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.gray.cgColor
        uiView.layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        uiView.layer.shadowRadius = 8.0
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.masksToBounds = false
    }

    func setupTapGesture(){
        let addressTap = UITapGestureRecognizer(target: self, action: #selector(self.addressTap(_:)))
        addressView.addGestureRecognizer(addressTap)
        
        let currencyTap = UITapGestureRecognizer(target: self, action: #selector(self.currencyTap(_:)))
        currencyView.addGestureRecognizer(currencyTap)
        
        let connectToUsTap = UITapGestureRecognizer(target: self, action: #selector(self.connectToUsTap(_:)))
        connectToUsView.addGestureRecognizer(connectToUsTap)
        
        let aboutInDoorTap = UITapGestureRecognizer(target: self, action: #selector(self.aboutInDoorTap(_:)))
        aboutInDoorView.addGestureRecognizer(aboutInDoorTap)
    }
    
    @objc func addressTap(_ sender: UITapGestureRecognizer? = nil) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "address") as! AddressViewController
        address.modalPresentationStyle = .fullScreen
        present(address, animated: true)
    }
    
    @objc func currencyTap(_ sender: UITapGestureRecognizer? = nil) {
        let currency = self.storyboard?.instantiateViewController(withIdentifier: "currency") as! CurrencyViewController
        currency.modalPresentationStyle = .fullScreen
        present(currency, animated: true)
    }
    
    @objc func connectToUsTap(_ sender: UITapGestureRecognizer? = nil) {
        let connect = self.storyboard?.instantiateViewController(withIdentifier: "connectToUs") as! ConnectToUsViewController
        connect.modalPresentationStyle = .fullScreen
        present(connect, animated: true)
    }
    
    @objc func aboutInDoorTap(_ sender: UITapGestureRecognizer? = nil) {
        let about = self.storyboard?.instantiateViewController(withIdentifier: "aboutInDoor") as! AboutInDoorViewController
        about.modalPresentationStyle = .fullScreen
        present(about, animated: true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}