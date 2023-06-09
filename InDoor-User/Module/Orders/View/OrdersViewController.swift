//
//  OrdersViewController.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var orderTableView: UITableView!
    var orders: [Orders] = []
    var ordersViewModel: OrdersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderTableView.register(UINib(nibName: Constants.orderNibFile, bundle: nil), forCellReuseIdentifier: Constants.orderCellIdentifier)
        ordersViewModel = OrdersViewModel(netWorkingDataSource: Network())
        callingData()
        
    }
    
    func callingData(){
        ordersViewModel.bindResultToViewController = {[weak self] in
            self?.orders = self?.ordersViewModel.result?.filter{$0.customer?.id == UserDefault().getCustomerId()} ?? []
            self?.orderTableView.reloadData()
        }
        ordersViewModel.getOrders()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderCellIdentifier, for: indexPath) as! OrderTableViewCell
        cell.setOrderValues(order: orders[indexPath.row])
        
        return cell
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.orderCellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: Constants.orderDetails) as! OrderDetailsViewController
        storyboard.modalPresentationStyle = .fullScreen
        storyboard.order = orders[indexPath.row]
        present(storyboard, animated: true)
    }
}
