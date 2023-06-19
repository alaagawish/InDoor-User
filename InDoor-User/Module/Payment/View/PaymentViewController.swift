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
    var paymentViewModel: PaymentViewModel!
    var canPayWithCash = true
    var order: Orders!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentViewModel = PaymentViewModel(netWorkingDataSource: Network())
        setupUI()
        setupTapGesture()
        cantPayWithCashView.translatesAutoresizingMaskIntoConstraints = false
        checkCashPayment()
        totalPriceLabel.text = order.totalPrice
        paymentViewModel.bindOrderToViewController = {
            [weak self] in
            if self?.paymentViewModel.order?.id ?? 0 != 0 {
            
                let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.congratulations, msg: "Order is done", negativeButtonTitle: Constants.ok, positiveButtonTitle: Constants.directHome) {[weak self] alert in
                    
                    let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
                    let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
                    home.modalPresentationStyle = .fullScreen
                   
                    self?.dismiss(animated: true)
                    self?.present(home, animated: true)
                    
                }
                self?.present(alert, animated: true)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        purchaseButton.isEnabled = false
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
        purchaseButton.isEnabled = true
    }
    
    @objc func cashTap(_ sender: UITapGestureRecognizer? = nil) {
        if canPayWithCash{
            cashCheckMarkImage.isHidden = true
        }else{
            cashCheckMarkImage.isHidden = false
            
        }
        creditCheckMarkImage.isHidden = true
        purchaseButton.isEnabled = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
       
    }
    
    
    @IBAction func doneOrder(_ sender: Any) {
        paymentViewModel.postOrder(order: order)
        
        
    }
}
