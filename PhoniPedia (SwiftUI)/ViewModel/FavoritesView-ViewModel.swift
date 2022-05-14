//
//  FavoritesView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/7/22.
//
import CoreData
import Foundation
import SwiftUI

extension FavoritesView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<SavedProduct>
        
        @Published var showSingleProductView = false
        @Published var showFetchError = false
        @Published var showProgressView = false
        @Published var phoneUrl = ""
        @Published var productDataObject: ProductDataObject!
        
        private let productApi = ProductApi()
        let moc = SharedProperties.sharedMoc
        
        func fetchProductDataObject(url: String) {
            
            productApi.getProductAlamofire(url: url) { [weak self] productObject in
                
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let object = productObject {
                        self.phoneUrl = url
                        self.productDataObject = object
                        self.showSingleProductView = true
                        
                        
                    } else {
                        
                        self.showFetchError = true
                        
                    }
                    
                    self.showProgressView = false
                }
            }
        }
        
        
        func removeFromFavorites(phone: SavedProduct) {
            
            moc.delete(phone)
            
            do {
                try moc.save()
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        func removeRows(at offsets: IndexSet) {
            if let rowNum = offsets.first {
                removeFromFavorites(phone: favorites[rowNum])
                
            }
        }
        
    }
}
