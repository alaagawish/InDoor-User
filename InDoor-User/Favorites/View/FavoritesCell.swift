//
//  FavoritesCell.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit
import Kingfisher

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    var localProduct: LocalProduct!
    var product: Product!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        
        // Configure the view for the selected state
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
    func setDataToTableCell(product: LocalProduct) {
        self.localProduct = product
        productImageView.kf.setImage(with: URL(string: localProduct.image ))
        productTitleLabel.text = Splitter().splitName(text: localProduct.title, delimiter: "| ")
        productPriceLabel.text =  "\(UserDefault().getCurrencySymbol()) " + String(format: "%.1f", Double(localProduct.price ?? "")! *  UserDefault().getCurrencyRate())
    }
    
    func setProductToTableCell(product: Product) {
        self.product = product
        productImageView.kf.setImage(with: URL(string: product.image?.src ?? ""))
        productTitleLabel.text = Splitter().splitName(text: product.title ?? "", delimiter: "| ")
        productPriceLabel.text = "\(UserDefault().getCurrencySymbol()) " + String(format: "%.1f", Double(product.variants?[0].price ?? "")! *  UserDefault().getCurrencyRate())
    }
    
}
