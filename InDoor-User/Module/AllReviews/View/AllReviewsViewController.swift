//
//  AllReviewsViewController.swift
//  InDoor-User
//
//  Created by Mac on 16/06/2023.
//

import UIKit

class AllReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var allReviewsTableView: UITableView!
    var reviewsList:[Review] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        allReviewsTableView.register(UINib(nibName:Constants.reviewNibFileName , bundle: nil), forCellReuseIdentifier: Constants.reviewCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.reviewCellIdentifier) as! ReviewTableViewCell
        cell.setData(review: reviewsList[indexPath.row])
        return cell
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
