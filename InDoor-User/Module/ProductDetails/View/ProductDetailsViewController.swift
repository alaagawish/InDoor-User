//
//  ProductDetailsViewController.swift
//  InDoor-User
//
//  Created by Mac on 13/06/2023.
//

import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

class ProductDetailsViewController: UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImagesSlider: ImageSlideshow!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productVendorAndType: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    
    var productImagesArr: [InputSource] = []
    var product:Product!
    var sizeCollectionHandler = ProductSizeCollectionDelegatesHandling()
    var colorCollectionHandler = ProductColorCollectionDelegatesHandling()
    var selectedSize: String!{
        didSet{
            checkPriceAndAvailability()
        }
    }
    var selectedColor: String!{
        didSet{
            checkPriceAndAvailability()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareProductImagesArr()
        initializeUI()
    }
    
    func prepareProductImagesArr(){
        for image in product.images!{
            productImagesArr.append(KingfisherSource(url: URL(string: image.src ?? "")!))
        }
    }
    
    func initializeUI(){
        prepareSizeCollection()
        prepareColorCollection()
        startSlider()
        productName.text = product.title
        productVendorAndType.text = "\(product.vendor ?? ""), \(product.productType ?? "")"
        descriptionLabel.text = product.bodyHtml
    }
    
    func prepareSizeCollection(){
        sizeCollectionHandler.sizeArr = product.options?[0].values ?? []
        sizeCollectionHandler.viewController = self
        sizeCollectionView.dataSource = sizeCollectionHandler
        sizeCollectionView.delegate = sizeCollectionHandler
        print(sizeCollectionHandler.sizeArr.count)
    }
    
    func prepareColorCollection(){
        colorCollectionHandler.colorArr = product.options?[1].values ?? []
        colorCollectionHandler.viewController = self
        colorCollectionView.dataSource = colorCollectionHandler
        colorCollectionView.delegate = colorCollectionHandler
        print(colorCollectionHandler.colorArr.count)
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
                    price.text = "\(variant.price)$"
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
    
}
