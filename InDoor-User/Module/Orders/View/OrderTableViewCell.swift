//
//  OrderTableViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var itemsNumber: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .white
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override var frame: CGRect{
        get {
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.origin.y += 8
            frame.size.width -= 2 * 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    func setOrderValues(order: Orders){
        self.orderNumber.text = order.name
        self.itemsNumber.text = "\(order.lineItems?.count ?? 1)"
        self.totalPrice.text = order.totalPrice
        
        self.status.text = order.financialStatus
    }
    
}
