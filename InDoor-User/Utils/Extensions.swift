//
//  Extensions.swift
//  InDoor-User
//
//  Created by Mac on 16/06/2023.
//

import UIKit

extension UICollectionViewCell {
    func elevateCellAndRemoveBorder (){
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    func addBorderAndRemoveShadow (){
        layer.shadowRadius = 0.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.0
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}

extension UITableViewCell {
    func elevateCellAndRemoveBorder (){
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        layer.shadowOpacity = 0.7
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    func addBorderAndRemoveShadow (){
        layer.shadowRadius = 0.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.0
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}
