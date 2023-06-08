//
//  BrandCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import UIKit
import Kingfisher

class BrandCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setValues(brandName: String, brandImage: String){
        
        self.brandName.text = brandName
        self.brandImageView.kf.setImage(with: URL(string: brandImage),
                                        placeholder: UIImage(named: Constants.noImage))
    }
    
}
