//
//  ProductsView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//
import CoreData
import Foundation
import SwiftUI


extension ProductsView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var showSingleProductView = false
        @Published var showFetchError = false
        @Published var showProgressView = false
        @Published var phoneUrl = ""
        @Published var before = false
        
        var productDataObject: ProductDataObject!
        let productApi = ProductApi()
        
        func fetchProductDataObject(url: String) {
            
            productApi.getProductAlamofire(url: url) { [weak self] productObject in
                
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let object = productObject {
                        
                        self.productDataObject = object
                        self.before = true
                        self.showSingleProductView = true
                        
                        
                    } else {
                        
                        self.showFetchError = true
                        
                    }
                    self.showProgressView = false
                }
            }
        } 
    }
}
