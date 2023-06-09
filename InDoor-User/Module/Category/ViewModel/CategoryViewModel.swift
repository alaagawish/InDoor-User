//
//  CategoryViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import Foundation
class CategoryViewModel{
    var bindResultToViewController: (()->()) = {}
    var bindProductToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Product]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindResultToViewController()
            }
        }
    }
    var product: Product = Product(id: 0, title: "", bodyHtml: "", vendor: "", productType: "", createdAt: "", handle: "", updatedAt: "", publishedAt: "", status: "", publishedScope: "", tags: "", adminGraphqlApiId: "", variants: [], options: [], images: [], image: Image(id: 0, productId: 0, position: 0, createdAt: "", updatedAt: "", width: 0, height: 0, src: "", adminGraphqlApiId: "")) {
        didSet{
            DispatchQueue.main.async {
                self.bindProductToViewController()
            }
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getItems(id: Int) {
        
        let path = "collections/\(id)/products"
        netWorkingDataSource.getData(path: path){ [weak self] (response : Response?) in
            self?.result = response?.products
        }
    }
    func getPrice(i: Product) {
        let path = "products/\(i.id)"
        netWorkingDataSource.getData(path: path){ [weak self] (response : Response?) in
            self?.product =  response?.product ?? Product(id: 0, title: "", bodyHtml: "", vendor: "", productType: "", createdAt: "", handle: "", updatedAt: "", publishedAt: "", status: "", publishedScope: "", tags: "", adminGraphqlApiId: "", variants: [], options: [], images: [], image: Image(id: 0, productId: 0, position: 0, createdAt: "", updatedAt: "", width: 0, height: 0, src: "", adminGraphqlApiId: "")) 
            
        }
    }
    
}
