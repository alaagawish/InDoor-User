//
//  HomeViewController.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var homeViewModel: HomeViewModel!
    let discountArray = ["discount1",
                         "discount2",
                         "discount5",
                         "discount3"]
    var timer: Timer?
    var currentIndex = 0
    var brands:[SmartCollections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(netWorkingDataSource: Network())
        homeViewModel.bindResultToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.brands = self?.homeViewModel.result ?? []
                self?.brandCollectionView.reloadData()
                
            }
        }
        pageControl.numberOfPages = discountArray.count
        startTimer()
        homeViewModel.getItems()
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveSlider), userInfo: nil, repeats: true)
    }
    @objc
    func moveSlider(){
        currentIndex = (currentIndex + 1) % sliderCollectionView.numberOfItems(inSection: 0)
        self.sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView{
            return discountArray.count
        }else{
            return brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slider", for: indexPath) as! SliderCollectionViewCell
            
            cell.discountImage.image = UIImage(named: discountArray[indexPath.row])
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCollectionViewCell
            
            cell.setValues(brandName: brands[indexPath.row].title ?? "", brandImage: brands[indexPath.row].image?.src ?? "")
            
            return cell
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView{
            return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height/3)
        }else{
            return CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: UIScreen.main.bounds.height/4 - 10)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView{
            return 0
        }else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sliderCollectionView{
            print(indexPath.row)
            print(discountArray[indexPath.row])
        }else{
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "brandHeader", for: indexPath) as! HeaderCollectionReusableView
        header.headerName.text = "Brands"
        return header
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
}
