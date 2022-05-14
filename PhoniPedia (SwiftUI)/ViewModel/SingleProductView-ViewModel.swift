//
//  SingleProductView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/7/22.
//
import CoreData
import Foundation
import SwiftUI


extension SingleProductView {
    
    @MainActor class ViewModel: ObservableObject {
        @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<SavedProduct>
        
        @Published var isFavorite = false
        @Published var showDetailsView = false
        @Published var showCoreDataError = false
        @Published var showSuccessMessage = false {
            didSet {
                if showSuccessMessage == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showSuccessMessage = false
                }
                }
            }
        }
        @Published var successMessageText = ""
        @Published var favoriteButtonText = "Add to favorites"
        @Published var favoriteButtonImage = Image(systemName: "star.fill")
        @Published var favoriteButtonBackground = Color.favoriteButtonBackground
        
        let moc =  SharedProperties.sharedMoc
        var currentProductUrl = ""
        var currentProduct = mockupData.productObject
        
        //        func favoriteButtonPressed(object: ProductDataObject) {
        //
        //
        //            if isFavorite {
        //                removeFromFavorites(phoneName: object.data.phoneName)
        //            } else {
        //                addToFavorites(object: object)
        //            }
        //        }
        
        func addToFavorites(object: ProductDataObject) {
            
            let product = SavedProduct(context: moc)
            product.phoneName = object.data.phoneName
            product.brandName = object.data.brand
            product.phoneImage = object.data.phoneImages[0]
            product.phoneDetails = currentProductUrl
            
            try! moc.save()
            successMessageText = "Successfully added to favorites"
            showSuccessMessage = true
            presentRemoveButton()
            
        }
        
        func removeFromFavorites(product: SavedProduct) {
            
            moc.delete(product)
            
            try! moc.save()
            successMessageText = "Successfully removed from favorites"
            showSuccessMessage = true
            presentAddButton()
            
        }
        
        
        func presentRemoveButton() {
            isFavorite = true
            favoriteButtonBackground = Color.removeButtonBackground
            favoriteButtonText = "Remove from favorites"
            favoriteButtonImage = Image(systemName: "star.slash")
        }
        
        func presentAddButton() {
            isFavorite = false
            favoriteButtonBackground = Color.favoriteButtonBackground
            favoriteButtonText = "Add to favorites"
            favoriteButtonImage = Image(systemName: "star.fill")
        }
        
        func returnSavedProduct() -> SavedProduct {
            let product = SavedProduct(context: moc)
            product.phoneName = currentProduct.data.phoneName
            product.brandName = currentProduct.data.brand
            product.phoneImage = currentProduct.data.phoneImages[0]
            product.phoneDetails = currentProductUrl
            return product
        }
        
        
    }
}
