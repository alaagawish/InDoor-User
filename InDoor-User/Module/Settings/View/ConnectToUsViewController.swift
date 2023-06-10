//
//  ConnectToUsViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class ConnectToUsViewController: UIViewController {
    
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var youtubeView: UIView!
    
    @IBOutlet weak var facebookFollowButton: UIButton!
    @IBOutlet weak var instagramFollowButton: UIButton!
    @IBOutlet weak var twitterFollowButton: UIButton!
    @IBOutlet weak var youtubeFollowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        facebookFollowButton.layer.cornerRadius = 12
        instagramFollowButton.layer.cornerRadius = 12
        twitterFollowButton.layer.cornerRadius = 12
        youtubeFollowButton.layer.cornerRadius = 12
        setupUIView(uiView: facebookView)
        setupUIView(uiView: instagramView)
        setupUIView(uiView: twitterView)
        setupUIView(uiView: youtubeView)
    }
    
    func setupUIView(uiView: UIView){
        uiView.layer.cornerRadius = 20
        uiView.layer.shadowColor = UIColor.gray.cgColor
        uiView.layer.shadowOffset = CGSize(width: 3.3, height: 5.7)
        uiView.layer.shadowRadius = 8.0
        uiView.layer.shadowOpacity = 0.35
        uiView.layer.masksToBounds = false
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
