//
//  BrandsCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
//        layer.cornerRadius = 20
//        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 20
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
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setValues(brandName: String, brandImage: String){
        
        self.brandName.text = brandName
        self.brandImageView.kf.setImage(with: URL(string: brandImage),
                                        placeholder: UIImage(named: Constants.noImage))
    }
//    override var frame: CGRect{
//        get {
//            return super.frame
//        }
//        set(newFrame){
//            var frame = newFrame
//            frame.origin.x += 8
//            frame.origin.y += 8
//            frame.size.width -= 2 * 8
//            frame.size.height -= 2 * 8
//            super.frame = frame
//        }
//    }

}
