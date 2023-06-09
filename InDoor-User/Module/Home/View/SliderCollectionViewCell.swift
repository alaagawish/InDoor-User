//
//  SliderCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var discountImage: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
