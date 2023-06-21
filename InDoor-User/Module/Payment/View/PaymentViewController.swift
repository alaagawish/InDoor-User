//
//  PaymentViewController.swift
//  InDoor-User
//
//  Created by Mac on 17/06/2023.
//

import UIKit
import PassKit

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
    var orderTotalPrice = 0.0
    var payRequest: PKPaymentRequest!
    var creditTappedFlag = false
    
    
    func getPaymentRequest() -> PKPaymentRequest{
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = "merchant.mad43team1.com"
        request.supportedNetworks = [.visa, .masterCard, .vPay, .quicPay]
        request.supportedCountries = ["US", "EG"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "\(UserDefault().getCurrencySymbol())"

        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Your order", amount: NSDecimalNumber(value: orderTotalPrice))]
        
        return request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payRequest = getPaymentRequest()
        paymentViewModel = PaymentViewModel(netWorkingDataSource: Network())
        setupUI()
        setupTapGesture()
        orderTotalPrice = Double(order.totalPrice ?? "") ?? 0 
        cantPayWithCashView.translatesAutoresizingMaskIntoConstraints = false
        checkCashPayment()
        self.purchaseButton.addTarget(self, action: #selector(tapToPay), for: .touchUpInside)
        
        totalPriceLabel.text = "\(UserDefault().getCurrencySymbol()) " + String(format: "%.2f", orderTotalPrice * UserDefault().getCurrencyRate())
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
    
    @objc func tapToPay(){
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: payRequest)
        guard let paymentController = paymentController else {
            return
        }
        paymentController.delegate = self
        present(paymentController, animated: true, completion: nil)
        creditCheckMarkImage.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        purchaseButton.isEnabled = false
    }
    func checkCashPayment(){
        if !canPayWithCash{
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
        if !canPayWithCash{
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
        creditTappedFlag = true
    }
    
    @objc func cashTap(_ sender: UITapGestureRecognizer? = nil) {
        if canPayWithCash{
            cashCheckMarkImage.isHidden = false
        }else{
            cashCheckMarkImage.isHidden = true
        }
        creditCheckMarkImage.isHidden = true
        purchaseButton.isEnabled = true
        creditTappedFlag = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func doneOrder(_ sender: Any) {
        paymentViewModel.postOrder(order: order)
        orderTotalPrice = 0.0
        ShoppingCartViewController.products = []
        if creditTappedFlag{
            tapToPay()
        }
        navigateToHomeAfterPay()
    }
    
    func navigateToHomeAfterPay(){
        let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Successful payment done", positiveButtonTitle: Constants.ok) { action in
            let storyboard = UIStoryboard(name: Constants.homeStoryboardName, bundle: nil)
            let home = storyboard.instantiateViewController(withIdentifier: Constants.homeIdentifier) as! MainTabBarController
            home.modalPresentationStyle = .fullScreen
            self.present(home, animated: true)
        }
        self.present(alert, animated: true)
    }
}

extension PaymentViewController: PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            self.orderTotalPrice = 0.0
            self.totalPriceLabel.text = "\(UserDefault().getCurrencySymbol()) \(0.0)"
            ShoppingCartViewController.products = []
            self.navigateToHomeAfterPay()
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
