//
//  BrandProductCollectionViewCell.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import UIKit

class BrandProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var viewController: BrandViewController?
    var categoryViewController: CategoryViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
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
    func setValues(image: String, title: String, isFav: Bool, viewController: BrandViewController ){
        self.viewController = viewController
        self.productTitle.text = Splitter().splitName(text: title, delimiter: "|")
        self.productImage.kf.setImage(with: URL(string: image),
                                      placeholder: UIImage(named: Constants.noImage))
        if isFav{
            self.favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        }else{
            self.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
        }
        
    }
    func setValuess(image: String, title: String, isFav: Bool, viewController: CategoryViewController ){
        self.categoryViewController = viewController
        self.productTitle.text = Splitter().splitName(text: title, delimiter: "|")
        self.productImage.kf.setImage(with: URL(string: image),
                                      placeholder: UIImage(named: Constants.noImage))
        if isFav{
            self.favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        }else{
            self.favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
        }
        
    }
    
    @IBAction func checkFavouriteProduct(_ sender: Any) {
        
        if favouriteButton.currentImage == UIImage(systemName: Constants.heart){
            print("adding to fav")
            favouriteButton.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        }else{
            print("removing")
            //            favouriteButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
            viewController?.present(Alert().removeFromFav(title: Constants.deleteTitle, msg: Constants.deleteMessage), animated: true, completion: nil)
        }
        
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
    
}
