//
//  ReviewsTableViewDelegatesHandling.swift
//  InDoor-User
//
//  Created by Mac on 15/06/2023.
//

import UIKit

class ReviewsTableViewDelegatesHandling: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var viewController: ProductDetailsViewController!
    var productReviews: [Review] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reviewCellIdentifier) as! ReviewTableViewCell
        cell.setData(review: productReviews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
   

}
