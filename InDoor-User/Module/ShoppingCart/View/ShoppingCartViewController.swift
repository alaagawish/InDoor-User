//
//  ShoppingCartViewController.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var shoppingCartTabelView: UITableView!
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingCartBottomView: UIView!
    @IBOutlet weak var applyCouponButton: UIButton!
    @IBOutlet weak var couponTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShoppingCartCellNibFile()
        setupUI()
    }
    
    func setShoppingCartCellNibFile(){
        let nibFile = UINib(nibName: Constants.nibFileName, bundle: nil)
        shoppingCartTabelView.register(nibFile, forCellReuseIdentifier: Constants.cartCellIdentifier)
    }
    
    func setupUI(){
        proceedToCheckoutButton.layer.cornerRadius = 12
        applyCouponButton.layer.cornerRadius = 12
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cartCellIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}

extension ShoppingCartViewController{
    class Constants{
        static let nibFileName = "ShoppingCartTableViewCell"
        static let cartCellIdentifier = "cartCell"
    }
}
