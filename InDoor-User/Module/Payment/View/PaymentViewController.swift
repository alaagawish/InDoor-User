//
//  PaymentViewController.swift
//  InDoor-User
//
//  Created by Mac on 17/06/2023.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var creditCheckMarkImage: UIImageView!
    @IBOutlet weak var cashCheckMarkImage: UIImageView!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var cantPayWithCashView: UIView!
    
    var canPayWithCash = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGesture()
        cantPayWithCashView.translatesAutoresizingMaskIntoConstraints = false
        checkCashPayment()
    }
    
    func checkCashPayment(){
        if canPayWithCash{
            cantPayWithCashView.isHidden = false
            if let heightConstraint = cantPayWithCashView.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.constant = UIScreen.main.bounds.height * 0.07
            }
        }
    }

    func setupUI(){
        purchaseButton.layer.cornerRadius = 12
        creditCheckMarkImage.isHidden = true
        cashCheckMarkImage.isHidden = true
        if canPayWithCash{
            cashView.isHidden = true
        }
        setupUIView(uiView: creditView)
        setupUIView(uiView: cashView)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.gray.cgColor
        uiView.layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        uiView.layer.shadowRadius = 4.0
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.masksToBounds = false
    }
    
    func setupTapGesture(){
        let creditTap = UITapGestureRecognizer(target: self, action: #selector(self.creditTap(_:)))
        creditView.addGestureRecognizer(creditTap)
        
        let cashTap = UITapGestureRecognizer(target: self, action: #selector(self.cashTap(_:)))
        cashView.addGestureRecognizer(cashTap)
    }
    
    @objc func creditTap(_ sender: UITapGestureRecognizer? = nil) {
        creditCheckMarkImage.isHidden = false
        cashCheckMarkImage.isHidden = true
    }
    
    @objc func cashTap(_ sender: UITapGestureRecognizer? = nil) {
        if canPayWithCash{
            cashCheckMarkImage.isHidden = true
            creditCheckMarkImage.isHidden = true
            
//            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Your order exceeds our cash on delivery method, you can only pay with credit card", positiveButtonTitle: Constants.ok)
//            present(alert, animated: true)
        }else{
            cashCheckMarkImage.isHidden = false
            creditCheckMarkImage.isHidden = true
        }
    }
    
    @IBAction func purchaseButton(_ sender: UIButton) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
