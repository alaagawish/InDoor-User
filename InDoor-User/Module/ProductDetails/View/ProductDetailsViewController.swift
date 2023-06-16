//
//  ProductDetailsViewController.swift
//  InDoor-User
//
//  Created by Mac on 13/06/2023.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher
import Cosmos

class ProductDetailsViewController: UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var addToCartOutlet: UIButton!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImagesSlider: ImageSlideshow!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productVendorAndType: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    
    var productImagesArr: [InputSource] = []
    var product:Product!
    var sizeCollectionHandler = ProductSizeCollectionDelegatesHandling()
    var colorCollectionHandler = ProductColorCollectionDelegatesHandling()
    var reviewTableHandler = ReviewsTableViewDelegatesHandling()
    var selectedSize: String!{
        didSet{
            var tempColorArr:[String] = []
                        for variant in product.variants! {
                if variant.option1 == selectedSize{
                    tempColorArr.append(variant.option2!)
                }
            }
            colorCollectionHandler.colorArr = tempColorArr
            colorCollectionView.reloadData()
            if selectedSize != nil{
                price.text = Constants.selectColor
                stockCount.text = Constants.selectColor
            }
            selectedColor = nil
            addToCartOutlet.isHidden = true
        }
    }
    var selectedColor: String!{
        didSet{
            checkPriceAndAvailability()
            if selectedSize != nil && selectedColor != nil {
                addToCartOutlet.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.register(UINib(nibName:Constants.reviewNibFileName , bundle: nil), forCellReuseIdentifier: Constants.reviewCellIdentifier)
        prepareProductImagesArr()
        initializeUI()
    }
    
    func prepareProductImagesArr(){
        for image in product.images!{
            productImagesArr.append(KingfisherSource(url: URL(string: image.src ?? "")!))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        addToCartOutlet.isHidden = true
        selectedSize = nil
        selectedColor = nil
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
    }
    func initializeUI(){
        prepareSizeCollection()
        prepareColorCollection()
        prepareReviewTable()
        startSlider()
        productName.text = product.title
        productVendorAndType.text = "\(product.vendor ?? ""), \(product.productType ?? "")"
        descriptionLabel.text = product.bodyHtml
        rating.settings.updateOnTouch = false
        rating.rating = Double(product.templateSuffix ?? "0.0") ?? 0.0
    }
    
    func prepareSizeCollection(){
        sizeCollectionHandler.viewController = self
        sizeCollectionView.dataSource = sizeCollectionHandler
        sizeCollectionView.delegate = sizeCollectionHandler
        sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
    }
    
    func prepareColorCollection(){
        colorCollectionHandler.viewController = self
        colorCollectionView.dataSource = colorCollectionHandler
        colorCollectionView.delegate = colorCollectionHandler
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
    }
    
    func prepareReviewTable(){
        reviewTableHandler.viewController = self
        reviewTableView.dataSource = reviewTableHandler
        reviewTableView.delegate = reviewTableHandler
        if Double(product.templateSuffix ?? "0.0") ?? 0.0 >= 3 && Double(product.templateSuffix ?? "0.0") ?? 0.0 <= 5{
            for i in 0 ..< 3{
                reviewTableHandler.productReviews.append(Constants.goodReviews[i])
            }
        } else {
            for i in 0 ..< 3{
                reviewTableHandler.productReviews.append(Constants.badReviews[i])
            }
        }
    }
    
    func startSlider(){
        productImagesSlider.slideshowInterval = 3.5
        productImagesSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        productImagesSlider.isUserInteractionEnabled = true
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        productImagesSlider.pageIndicator = pageControl
        productImagesSlider.activityIndicator = DefaultActivityIndicator()
        productImagesSlider.delegate = self
        productImagesSlider.setImageInputs(productImagesArr)
    }
    
    func checkPriceAndAvailability(){
        if selectedSize == nil || selectedColor == nil {}
        else{
            for variant in product.variants!{
                let variantName = "\(selectedSize!) / \(selectedColor!)"
                if variant.title! == variantName{
                    price.text = String(format: "%.2f", (Double(variant.price) ?? 0 ) *  UserDefault().getCurrencyRate()) + " \(UserDefault().getCurrencySymbol())"
 
                    if variant.inventoryQuantity == nil || variant.inventoryQuantity == 0 {
                        stockCount.text = "Not Available"
                    }else{
                        stockCount.text = "\(variant.inventoryQuantity!) In Stock"
                    }
                }
            }
        }
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didTapAt index: Int) {
        print(index)
        let currentImage = productImagesSlider.currentSlideshowItem?.imageView.image
        if let imageString = currentImage?.description {
            print("Image String: \(imageString)")
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func seeAllReviews(_ sender: UIButton) {
        let allReviews = self.storyboard?.instantiateViewController(identifier: Constants.allReviewsIdentifier) as! AllReviewsViewController
        allReviews.modalPresentationStyle = .fullScreen
        if Double(product.templateSuffix ?? "0.0") ?? 0.0 >= 3 && Double(product.templateSuffix ?? "0.0") ?? 0.0 <= 5{
            allReviews.reviewsList = Constants.goodReviews
        } else {
            allReviews.reviewsList = Constants.badReviews
        }
        self.present(allReviews, animated: true)
    }
    @IBAction func addOrRemoveFromFavorites(_ sender: UIButton) {
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
    }
}
