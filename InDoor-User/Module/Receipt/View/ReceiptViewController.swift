//
//  ReceiptViewController.swift
//  InDoor-User
//
//  Created by Alaa on 14/06/2023.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    @IBOutlet weak var applyCouponButton: UIButton!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var viewModel = ReceiptViewModel(netWorkingDataSource: Network())
    var subtotalPrice: Double?
    var couponName: String = ""
    var couponType: String = ""
    var couponAmount: String = ""
    var couponMinimumSubTotal: String = ""
    var lineItmes: [LineItems] = []
    var total: Double = 0.0
    var allCoupons:[[DiscountCodes]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsCollectionView.register(UINib(nibName: Constants.orderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.orderCellIdentifier)
        
        setUpUI()
        getCouponsFromApi()
    }
    
    func getCouponsFromApi(){
        viewModel.getAllPriceRules { priceRules in
            for priceRule in priceRules {
                self.viewModel.getAllDiscountCoupons(priceRule: priceRule) { [weak self] priceRuleCoupons in
                    self?.allCoupons.append(priceRuleCoupons)
                }
            }
        }
    }
    
    func setUpUI(){
        applyCouponButton.layer.cornerRadius = 12
        checkoutButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        couponName = UserDefault().getCoupon().0
        couponType = UserDefault().getCoupon().1
        subtotal.text = "\(UserDefault().getCurrencySymbol())"
        subtotal.text! += String(format: "%.2f", (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())
        totalMoney.text = "\(UserDefault().getCurrencySymbol())"
        totalMoney.text! += String(format: "%.2f", (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())
        couponAmount = UserDefault().getCouponAmountAndSubtotal().0
        couponMinimumSubTotal = UserDefault().getCouponAmountAndSubtotal().1
        couponTextField.text = couponName
        if  couponName != "" {
            applyCouponToPrice()
        }
        total = subtotalPrice ?? 0.0
        itemsCollectionView.reloadData()
    }
    
    @IBAction func checkout(_ sender: Any) {
        let customer = Customer(id: UserDefault().getCustomerId())
        let order = Orders(currency: UserDefault().getCurrencySymbol(), lineItems: lineItmes, number: lineItmes.count, customer: customer, totalPrice: String(format: "%.2f", total ))
        
        let storyboard = UIStoryboard(name: Constants.settingsStoryboard, bundle: nil)
        let addressStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.addressIdentifier) as! AddressViewController
        addressStoryboard.modalPresentationStyle = .fullScreen
        addressStoryboard.orderFlag = true
        addressStoryboard.order = order
        present(addressStoryboard, animated: true)
    }
    
    func applyCouponToPrice(){
        if (self.applyCouponButton.titleLabel?.text)! == "Apply" {
            var valid = false
            if couponName != "" {
                if couponTextField.text! == couponName {
                    valid = true
                }else{
                    for index in allCoupons.indices {
                        for coupon in allCoupons[index] {
                            if couponTextField.text == coupon.code {
                                valid = true
                                couponName = coupon.code!
                                viewModel.getSpecificPriceRule(id: String(coupon.priceRuleId!)) {[weak self] priceRule in
                                    self?.couponType = priceRule.valueType!
                                    self?.couponAmount = priceRule.value!
                                    self?.couponMinimumSubTotal = (priceRule.prerequisiteSubtotalRange?.greaterThanOrEqualTo!)!
                                }
                                break
                            }
                        }
                    }
                }
                if valid {
                    var discountAmount = 0.0
                    if Double(subtotal.text!) ?? 0 >= Double(couponMinimumSubTotal) ?? 0 {
                        self.couponTextField.isEnabled = false
                        self.applyCouponButton.setTitle("Change", for: .normal)
                        self.applyCouponButton.setTitleColor(.green, for: .normal)
                        if couponType == "percentage"{
                            
                            discountAmount = Double(subtotal.text!)! * Double(couponAmount)! / 100.0
                            totalMoney.text = String(Double(subtotal.text!)! - discountAmount)
                            total = Double(subtotal.text!)! - discountAmount
                        }
                        else {
                            discountAmount = Double(couponAmount)!
                            
                            totalMoney.text = "\(UserDefault().getCurrencySymbol())"
                            totalMoney.text! += String(format: "%.2f", ((Double(subtotal.text!)! + discountAmount) * UserDefault().getCurrencyRate()))
                            total = Double(subtotal.text!)! + discountAmount * UserDefault().getCurrencyRate()
                        }
                    }else{
                        let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Minimum Amount for this coupon to be applicable is \(self.couponMinimumSubTotal)", positiveButtonTitle: Constants.ok)
                        present(alert, animated: true)
                    }
                    self.discount.text =  "\(discountAmount)"
                    totalMoney.text = "\(UserDefault().getCurrencySymbol())"
                    totalMoney.text! += String(format: "%.2f", ((subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate()))
                    total = (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate()
                    discount.text = "-0.0"
                }else {
                    let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Invalid coupon", positiveButtonTitle: Constants.ok)
                    present(alert, animated: true)
                    totalMoney.text = "\(UserDefault().getCurrencySymbol())"
                    totalMoney.text! += String(format: "%.2f", (((subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())))
                    
                    total = (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate()
                    discount.text = "-0.0"
                }
            }
        }else{
            self.couponTextField.isEnabled = true
            self.applyCouponButton.setTitle("Apply", for: .normal)
            self.applyCouponButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func applyCoupon(_ sender: Any) {
        applyCouponToPrice()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ReceiptViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartList.cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderCollectionViewCell
        cell.setValues(cartItem: CartList.cartItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.5 - 10, height: UIScreen.main.bounds.height/4 - 12)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
