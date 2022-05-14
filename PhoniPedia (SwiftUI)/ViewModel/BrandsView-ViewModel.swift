//
//  BrandsView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//
import CoreData
import Foundation

extension BrandsView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var showFetchError = false
        @Published var showProgressView = false
        @Published var showProductsView = false
        
        var brandDataObject: BrandDataObject!
        private let brandApi = BrandApi()
        
        func fetchBrandDataObject(brandSlug: String) {
            
            brandApi.getBrandAlamofire(brandSlug: brandSlug) { [weak self] brandObject in
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let brandObject = brandObject {
                        
                        self.brandDataObject = brandObject
                        self.showProductsView = true
                        
                    } else {
                        
                        self.showFetchError = true
                        
                    }
                    
                    self.showProgressView = false
                }
            }
        } 
    }
}
