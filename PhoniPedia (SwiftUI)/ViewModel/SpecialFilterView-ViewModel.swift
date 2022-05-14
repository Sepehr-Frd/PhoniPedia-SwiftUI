//
//  SpecialFilterView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/6/22.
//
import CoreData
import Foundation

extension SpecialFilterView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var showSingleProductView = false
        @Published var showProgressView = false
        @Published var showFetchError = false
        @Published var productUrl = ""
        
        var productDataObject: ProductDataObject!
        private let productApi = ProductApi()
        
        func fetchProductDataObject(url: String) {
            
            productApi.getProductAlamofire(url: url) { [weak self] productObject in
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let productObject = productObject {
                        self.productUrl = url
                        self.productDataObject = productObject
                        self.showSingleProductView = true
                        
                        
                    } else {
                        
                        self.showSingleProductView = false
                        self.showFetchError = true
                        
                    }
                    self.showProgressView = false
                }
            }
        }
        
    }
}
