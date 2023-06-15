//
//  OrderCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 14/06/2023.
//

import UIKit
import Kingfisher

class OrderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemAmount: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues(image: String, amount: String, title: String) {
        self.itemTitle.text = title
        self.itemAmount.text = amount
        self.orderImage.kf.setImage(with: URL(string: image ),
                                    placeholder: UIImage(named: Constants.noImage))
        
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
    }
    
}
