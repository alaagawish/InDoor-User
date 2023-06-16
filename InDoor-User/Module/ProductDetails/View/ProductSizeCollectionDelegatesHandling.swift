//
//  ProductSizeCollectionDelegatesHandling.swift
//  InDoor-User
//
//  Created by Mac on 13/06/2023.
//

import UIKit

class ProductSizeCollectionDelegatesHandling: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var sizeArr:[String] = []
    var viewController:ProductDetailsViewController!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellName, for: indexPath) as! SizeCollectionViewCell
        cell.setData(size: sizeArr[indexPath.row])
        if viewController.selectedSize == sizeArr[indexPath.row]{
            cell.addBorderAndRemoveShadow()
        } else {
            cell.elevateCellAndRemoveBorder()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4-16, height: collectionView.frame.width/4-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.selectedSize = sizeArr[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.addBorderAndRemoveShadow()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.elevateCellAndRemoveBorder()
    }
}

extension ProductSizeCollectionDelegatesHandling{
    class Constants{
        static var cellName = "sizeCollectionCell"
    }
}
