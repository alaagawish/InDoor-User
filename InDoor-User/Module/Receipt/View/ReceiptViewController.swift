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
    @IBOutlet weak var subTotalCurrencyLabel: UILabel!
    @IBOutlet weak var totalMoneyCurrencyLabel: UILabel!
    @IBOutlet weak var discountCurrencyLabel: UILabel!
    var viewModel = ReceiptViewModel(netWorkingDataSource: Network())
    var subtotalPrice: Double?
    var couponName: String = ""
    var couponType: String = ""
    var couponAmount: String = ""
    var couponMinimumSubTotal: String = ""
    var priceRuleArr: [PriceRule] = []
    var total: Double = 0.0 {
        didSet{
            totalMoney.text! = String(format: "%.1f", total)
        }
    }
    var allCoupons:[[DiscountCodes]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsCollectionView.register(UINib(nibName: Constants.orderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.orderCellIdentifier)
        
        setUpUI()
        getCouponsFromApi()
    }
    
    func getCouponsFromApi(){
        viewModel.getAllPriceRules { [weak self] priceRules in
            self?.priceRuleArr = priceRules
            for priceRule in priceRules {
                self?.viewModel.getAllDiscountCoupons(priceRule: priceRule) { [weak self] priceRuleCoupons in
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
        prepareCheckOutData()
        getCouponData()
        if couponName != "" {
            couponTextField.text = couponName
            applyCouponToPrice()
        }else{
            total = subtotalPrice ?? 0.0
        }
        itemsCollectionView.reloadData()
    }
    
    func getCouponData(){
        couponAmount = UserDefault().getCouponAmountAndSubtotal().0
        couponName = UserDefault().getCoupon().0
        couponType = UserDefault().getCoupon().1
        couponMinimumSubTotal = UserDefault().getCouponAmountAndSubtotal().1
    }
    
    func prepareCheckOutData(){
        subTotalCurrencyLabel.text = "\(UserDefault().getCurrencySymbol())"
        subtotal.text! = String(format: "%.1f", (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())
        totalMoneyCurrencyLabel.text = "\(UserDefault().getCurrencySymbol())"
        discountCurrencyLabel.text = "\(UserDefault().getCurrencySymbol())"
        totalMoney.text! = String(format: "%.1f", (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())
    }
    
    @IBAction func checkout(_ sender: Any) {
        changeApplyCouponButtonTitleToApply()
        let customer = Customer(id: UserDefault().getCustomerId())
        let order = Orders(currency: UserDefault().getCurrencySymbol(), lineItems: CartList.cartItems, number: CartList.cartItems.count, customer: customer, totalPrice: String(format: "%.1f", total ))
        let storyboard = UIStoryboard(name: Constants.settingsStoryboard, bundle: nil)
        let addressStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.addressIdentifier) as! AddressViewController
        addressStoryboard.modalPresentationStyle = .fullScreen
        addressStoryboard.orderFlag = true
        addressStoryboard.order = order
        present(addressStoryboard, animated: true)
        discount.text = "-0.0"
        couponTextField.text = ""
    }
    
    @IBAction func applyCoupon(_ sender: Any) {
        applyCouponToPrice()
    }
    
    func changeApplyCouponButtonTitleToApply(){
        self.couponTextField.isEnabled = true
        self.applyCouponButton.setTitle("Apply", for: .normal)
        self.applyCouponButton.setTitleColor(.white, for: .normal)
    }
    
    func changeApplyCouponButtonTitleToChange(){
        self.couponTextField.isEnabled = false
        self.applyCouponButton.setTitle("Change", for: .normal)
        self.applyCouponButton.setTitleColor(.green, for: .normal)
    }
    
    func applyCouponToPrice(){
        if (self.applyCouponButton.titleLabel?.text)! == "Apply" {
            if checkCouponValidity() {
                if checkCouponEligbility() {
                    let discountAmount = calculateDiscount()
                    self.discount.text =  "\(discountAmount)"
                    total = ((subtotalPrice ?? 0.0) + discountAmount) * UserDefault().getCurrencyRate()
                }
            }else{
                showInvalidCouponAlert()
            }
        }else{
            changeApplyCouponButtonTitleToApply()
        }
    }
    
    func checkCouponValidity() -> Bool{
        if couponTextField.text! != "" {
            if couponTextField.text! == couponName {
                return true
            }else{
                for index in allCoupons.indices {
                    for coupon in allCoupons[index] {
                        if couponTextField.text == coupon.code {
                            couponName = coupon.code!
                            for priceRule in priceRuleArr{
                                if coupon.priceRuleId == priceRule.id{
                                    couponType = priceRule.valueType!
                                    couponAmount = priceRule.value!
                                    couponMinimumSubTotal = (priceRule.prerequisiteSubtotalRange?.greaterThanOrEqualTo!)!
                                    return true
                                }
                            }
                        }
                    }
                }
                return false
            }
        }else{
            return false
        }
    }
    
    func checkCouponEligbility() -> Bool {
        if subtotalPrice ?? 0 >= Double(couponMinimumSubTotal) ?? 0 {
            changeApplyCouponButtonTitleToChange()
            return true
        }else {
            let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Minimum Amount for this coupon to be applicable is \(self.couponMinimumSubTotal)", positiveButtonTitle: Constants.ok)
            present(alert, animated: true)
            return false
        }
    }
    
    func calculateDiscount() -> Double {
        var discountAmount = 0.0
        if couponType == "percentage"{
            discountAmount = Double(subtotal.text!)! * Double(couponAmount)! / 100.0
        }
        else {
            discountAmount = Double(couponAmount)!
        }
        return discountAmount
    }
    
    func showInvalidCouponAlert(){
        let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "Invalid coupon", positiveButtonTitle: Constants.ok)
        present(alert, animated: true)
        totalMoney.text! = String(format: "%.1f", (((subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate())))
        
        total = (subtotalPrice ?? 0.0) * UserDefault().getCurrencyRate()
        discount.text = "-0.0"
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
