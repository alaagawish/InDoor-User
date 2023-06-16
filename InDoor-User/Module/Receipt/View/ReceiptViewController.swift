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
    var subtotalPrice: Double?
    var coupon: String = ""
    var products: [Product] = []
    var amountPerProduct: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsCollectionView.register(UINib(nibName: Constants.orderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.orderCellIdentifier)
        setUpUI()
        
    }
    func setUpUI(){
        applyCouponButton.layer.cornerRadius = 12
        checkoutButton.layer.cornerRadius = 12
    }
    override func viewWillAppear(_ animated: Bool) {
        if  UserDefaults().string(forKey: Constants.couponChosen) != "null" {
            self.coupon = UserDefaults().string(forKey: Constants.couponChosen) ?? ""
            couponTextField.text = self.coupon
            applyCoupon(self.applyCouponButton)
        }
        
    }
    
    @IBAction func checkout(_ sender: Any) {
        
        
    }
    @IBAction func applyCoupon(_ sender: Any) {
        if self.applyCouponButton.titleLabel?.text == "Apply" {
            if coupon != "" {
                if couponTextField.text == coupon {
                    self.couponTextField.isEnabled = false
                    self.applyCouponButton.setTitle("Change", for: .normal)
                    self.applyCouponButton.setTitleColor(.green, for: .normal)
                    
                }
                let discountAmount = (subtotalPrice ?? 0) * (Double(self.coupon ) ?? 0.0)
                self.discount.text =  "- \(discountAmount )"
                self.totalMoney.text = "\((subtotalPrice ?? 0) - discountAmount)"
            }else{
                //check if coupon text field contains coupon in list back from api
                
                
            }
            
        }else {
            self.couponTextField.isEnabled = true
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ReceiptViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderCollectionViewCell
        cell.setValues(image: products[indexPath.row].image?.src ?? "", amount: "\(amountPerProduct[indexPath.row])", title:  products[indexPath.row].title ?? "")
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
      
}
