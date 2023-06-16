//
//  ProductColorCollectionDelegatesHandling.swift
//  InDoor-User
//
//  Created by Mac on 13/06/2023.
//

import UIKit

class ProductColorCollectionDelegatesHandling: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var viewController:ProductDetailsViewController!
    
    var colorArr: [String] = []{
        willSet{
            for index in colorArr.indices {
                self.collectionView(viewController.colorCollectionView, didDeselectItemAt: IndexPath(row: index, section: 0))
            }
            self.viewController.colorCollectionView.reloadData()
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellName, for: indexPath) as! ColorCollectionViewCell
        cell.setData(color: colorArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4-16, height: collectionView.frame.width/4-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewController.selectedSize != nil {
            viewController.selectedColor = colorArr[indexPath.row]
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.addBorderAndRemoveShadow()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.elevateCellAndRemoveBorder()
    }
}

extension ProductColorCollectionDelegatesHandling{
    class Constants{
        static var cellName = "colorCollectionCell"
    }
}
