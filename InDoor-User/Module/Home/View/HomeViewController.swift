//
//  HomeViewController.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageSlideshowDelegate {
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var couponsSlider: ImageSlideshow!
    var homeViewModel: HomeViewModel!
    
    let promoCodes = [ImageSource(image: UIImage(named: "discount5")!),
                      ImageSource(image: UIImage(named: "discount1")!),
                      ImageSource(image: UIImage(named: "discount2")!),
                      ImageSource(image: UIImage(named: "discount3")!)]
    
    
    var timer: Timer?
    var currentIndex = 0
    var brands:[SmartCollections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(netWorkingDataSource: Network())
        brandCollectionView.register(UINib(nibName: Constants.brandsNibFile, bundle: nil), forCellWithReuseIdentifier: Constants.brandCell)
        startSlider()
        callingData()
        
    }
    
    func callingData(){
        homeViewModel.bindResultToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.brands = self?.homeViewModel.result ?? []
                self?.brandCollectionView.reloadData()
                
            }
        }
        homeViewModel.getItems()
    }
    
    func startSlider(){
        couponsSlider.slideshowInterval = 2.5
        couponsSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        couponsSlider.isUserInteractionEnabled = true
        
        couponsSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        couponsSlider.pageIndicator = pageControl
        couponsSlider.activityIndicator = DefaultActivityIndicator()
        couponsSlider.delegate = self
        couponsSlider.setImageInputs(promoCodes)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        couponsSlider.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func imageTapped() {
        let tappedImageIndex = couponsSlider.currentPage
        
        print("current page\(tappedImageIndex)")
        
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didTapAt index: Int) {
        print(index)
        //        let currentImage = couponsSlider.currentSlideshowItem?.imageView.image
        //        if let imageString = currentImage?.description {
        //
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return brands.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.brandCell, for: indexPath) as! BrandsCollectionViewCell
        
        cell.setValues(brandName: brands[indexPath.row].title ?? "", brandImage: brands[indexPath.row].image?.src ?? "")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let products = self.storyboard?.instantiateViewController(withIdentifier: Constants.brandDetails) as! BrandViewController
        products.modalPresentationStyle = .fullScreen
        products.id = brands[indexPath.row].id
        present(products, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 15, height: UIScreen.main.bounds.height/4 - 15)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    @IBAction func navigateToFavoritesScreen(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: Constants.favoritesStoryboardName, bundle: nil)
        let favoritesStoryBoard = storyboard.instantiateViewController(withIdentifier: Constants.favoritesStoryboardName) as! FavoritesViewController
        favoritesStoryBoard.modalPresentationStyle = .fullScreen
        present(favoritesStoryBoard, animated: true)
    }
    @IBAction func moveToShoppingCart(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Constants.cartStoryboard, bundle: nil)
        let cartStoryboard = storyboard.instantiateViewController(withIdentifier: Constants.cartIdentifier) as! ShoppingCartViewController
        cartStoryboard.modalPresentationStyle = .fullScreen
        present(cartStoryboard, animated: true)
    }
}
