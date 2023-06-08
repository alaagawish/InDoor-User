//
//  AddressViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var addressesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        addAddressButton.layer.cornerRadius = 12
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addAddressButton(_ sender: UIButton) {
        let addAddress = self.storyboard?.instantiateViewController(withIdentifier: "addAddress") as! AddAddressViewController
        addAddress.modalPresentationStyle = .fullScreen
        present(addAddress, animated: true)
    }
}
