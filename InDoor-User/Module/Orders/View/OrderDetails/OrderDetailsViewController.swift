//
//  OrderDetailsViewController.swift
//  InDoor-User
//
//  Created by Alaa on 17/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var itemsNum: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneShippingAddress: UILabel!
    @IBOutlet weak var nameShippingAddress: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    
    var order: Orders!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        address.text = order.customer?.defaultAddress?.address1
        phoneShippingAddress.text = order.customer?.defaultAddress?.phone
        orderNumber.text = order.name
        itemsNum.text = "\(order.lineItems?.count ?? 0)"
        items.text = getItems(items: order.lineItems ?? [])
        status.text = order.financialStatus
        nameShippingAddress.text = order.customer?.defaultAddress?.name
        totalPrice.text = order.currentTotalPrice
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func getItems(items: [LineItems])-> String {
        var item = ""
        for i in items {
            item += i.name ?? ""
            item += "\n"
        }
        return item
    }
}
