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
    
    var orders: [Orders] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsCollectionView.register(UINib(nibName: Constants.orderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.orderCellIdentifier)
        setUpUI()
        
    }
    func setUpUI(){
        applyCouponButton.layer.cornerRadius = 12
        checkoutButton.layer.cornerRadius = 12
    }
    
    
    @IBAction func checkout(_ sender: Any) {
        
    }
    @IBAction func applyCoupon(_ sender: Any) {
        
    }
    
}

extension ReceiptViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderCollectionViewCell
        
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
