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
    
    @IBOutlet weak var favouriteButtonOutlet: UIButton!
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
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var counterTextField: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    var productDetailsViewModel: ProductDetailsViewModel!
    var defaults: UserDefaults!
    var productImagesArr: [InputSource] = []
    var product:Product!
    var orderedProduct: Product!
    var orderCount = 1{
        didSet{
            //label = orderCount
            //check minus button -> count < 1
        }
    }
    var productInCart = false
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
            minusButton.isEnabled = false
            addToCartView.isHidden = true
            counterTextField.text = "1"
            bottomSpace.constant = 16
        }
    }
    var selectedColor: String!{
        didSet{
            checkPriceAndAvailability()
            if selectedSize != nil && selectedColor != nil {
                addToCartView.isHidden = false
                bottomSpace.constant = 85
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailsViewModel = ProductDetailsViewModel(service: DatabaseManager.instance)
        defaults = UserDefaults.standard
        reviewTableView.register(UINib(nibName:Constants.reviewNibFileName , bundle: nil), forCellReuseIdentifier: Constants.reviewCellIdentifier)
        prepareProductImagesArr()
        initializeUI()
        orderedProduct = product
        orderedProduct.variants = []
        checkCart()
    }
    
    func prepareProductImagesArr(){
        for image in product.images!{
            productImagesArr.append(KingfisherSource(url: URL(string: image.src ?? "")!))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefault().getCustomerId() == -1 {
            favouriteButtonOutlet.isHidden = true
        }else {
            favouriteButtonOutlet.isHidden = false
        }
        addToCartView.isHidden = true
        bottomSpace.constant = 16
        counterTextField.text = "1"
        selectedSize = nil
        selectedColor = nil
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
        resetVariantsUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        colorCollectionView.reloadData()
        sizeCollectionView.reloadData()
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
        let isFav = productDetailsViewModel.checkIfProductIsFavorite(productId: product.id, customerId: defaults.integer(forKey: Constants.customerId))
        if isFav {
            self.favouriteButtonOutlet.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
        } else {
            self.favouriteButtonOutlet.setImage(UIImage(systemName: Constants.heart), for: .normal)
        }
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
        if favouriteButtonOutlet.currentImage == UIImage(systemName: Constants.heart) {
            let localProduct = LocalProduct(id: product.id, customer_id: defaults.integer(forKey: Constants.customerId), title: product.title ?? "", price: product.variants?[0].price ?? "", image: product.image?.src ?? "")
            productDetailsViewModel.addProduct(product: localProduct)
            favouriteButtonOutlet.setImage(UIImage(systemName: Constants.fillHeart), for: .normal)
            
        } else {
                let retrievedProduct = productDetailsViewModel.getProduct(productId: self.product.id )
                
                let alert = Alert().showRemoveProductFromFavoritesAlert(title: Constants.removeAlertTitle, msg: Constants.removeAlertMessage) { [weak self] action in
                    self?.productDetailsViewModel.removeProduct(product: retrievedProduct)
                    self?.favouriteButtonOutlet.setImage(UIImage(systemName: Constants.heart), for: .normal)
                }
                present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        let variantName = "\(selectedSize!) / \(selectedColor!)"
        
        if !checkVariantIsInCart(variantName: variantName){
            addVariantToOrders(variantName: variantName)
        }
    }
    
    func checkCart(){
        for cartProduct in ShoppingCartViewController.products{
            if cartProduct.id == orderedProduct.id {
                orderedProduct = cartProduct
                productInCart = true
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if productInCart {
            for index in ShoppingCartViewController.products.indices {
                if ShoppingCartViewController.products[index].id == orderedProduct.id {
                    ShoppingCartViewController.products[index] = orderedProduct
                    break
                }
            }
        }else{
            ShoppingCartViewController.products.append(orderedProduct)
        }
    }
    
    func checkVariantIsInCart(variantName: String) -> Bool{
        for index in orderedProduct.variants!.indices {
            if orderedProduct.variants?[index].title == variantName {
                if (orderedProduct.variants![index].oldInventoryQuantity)! > 3 && (orderedProduct.variants![index].inventoryQuantity)! + orderCount <= (orderedProduct.variants![index].oldInventoryQuantity)!/3 || (orderedProduct.variants![index].oldInventoryQuantity)! <= 3 && (orderedProduct.variants![index].inventoryQuantity)! + orderCount <= (orderedProduct.variants![index].oldInventoryQuantity)!{
                    orderedProduct.variants?[index].inventoryQuantity! += orderCount
                    orderCount = 1
                    resetVariantsUI()
                    
                }else{
                    var cartCount = 0
                    if (orderedProduct.variants?[index].oldInventoryQuantity)! <= 3{
                        cartCount = (orderedProduct.variants?[index].oldInventoryQuantity)!
                    }else{
                        cartCount = (orderedProduct.variants?[index].oldInventoryQuantity)! / 3
                    }
                    let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "\((orderedProduct.variants?[index].inventoryQuantity)!) of this varient already in your cart and you can't order more than \(cartCount)", positiveButtonTitle: Constants.ok)
                    present(alert, animated: true)
                }
                return true
            }
        }
        return false
    }
    
    func addVariantToOrders(variantName: String){
        for variant in product.variants! {
            if variant.title == variantName {
                if variant.inventoryQuantity! > 3 && orderCount < variant.inventoryQuantity!/3 || variant.inventoryQuantity! <= 3 && orderCount <= variant.inventoryQuantity! {
                    let orderedVariant = Variants(id: variant.id, productId:product.id ,title: variant.title, price: variant.price, option1: variant.option1, option2: variant.option2, inventoryQuantity: orderCount, oldInventoryQuantity: variant.inventoryQuantity)
                    orderedProduct.variants?.append(orderedVariant)
                    orderCount = 1
                    resetVariantsUI()
                }else{
                    let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: "you can't order more than \(variant.inventoryQuantity!/3)", positiveButtonTitle: Constants.ok)
                    present(alert, animated: true)
                }
            }
        }
    }
    
    func resetVariantsUI(){
       // addToCartOutlet.isHidden = true
        addToCartView.isHidden = true
        selectedSize = nil
        selectedColor = nil
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
        sizeCollectionView.reloadData()
        price.text = Constants.selectSize
        stockCount.text = Constants.selectSize
    }
    
    @IBAction func increaseCounter(_ sender: UIButton) {
        let count = Int(counterTextField.text ?? "1")
        counterTextField.text = String((count ?? 1) + 1)
        if Int(counterTextField.text ?? "1") != 1 {
            minusButton.isEnabled = true
        }
    }
    
    @IBAction func decreaseCounter(_ sender: Any) {
        let count = Int(counterTextField.text ?? "1")
        if count != 1 {
            counterTextField.text = String((count ?? 0) - 1)
            minusButton.isEnabled = true
        }
        if Int(counterTextField.text ?? "1") == 1{
            minusButton.isEnabled = false
        }
    }
}
