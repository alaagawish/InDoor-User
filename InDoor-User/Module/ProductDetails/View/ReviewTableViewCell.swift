//
//  ReviewTableViewCell.swift
//  InDoor-User
//
//  Created by Mac on 16/06/2023.
//

import UIKit
import Cosmos
import Kingfisher
class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewMessage: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var photo: UIImageView!
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
    
    func setData(review: Review){
        photo.kf.setImage(with: URL(string: review.photo))
        personName.text = review.personName
        rating.rating = review.rate
        reviewMessage.text = review.reviewMessage
    }
    
}
