//
//  SearchView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/6/22.
//
import CoreData
import Foundation

extension SearchView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var searchText: String = ""
        @Published var showProgressView = false
        @Published var showFetchError = false
        @Published var showSingleProductView = false
        @Published var showSearchResult = false
        @Published var showNoResultMessage = false
        @Published var phoneUrl = ""
        
        let noResultMessage =
                """
                    No product found.
                    Please try another name.
                """
        let productApi = ProductApi()
        let searchApi = SearchApi()
        var searchResult: BrandDataObject!
        var productDataObject: ProductDataObject!
        
        
        func fetchSearchResult() {
            
            searchApi.searchWithNameAlamofire(phoneName: searchText) { [weak self] brandObject in
                
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let brandObject = brandObject {
                        
                        if brandObject.data.phones.isEmpty {
                            
                            self.showNoResultMessage = true
                            
                        } else {
                            self.searchResult = brandObject
                            self.showSearchResult = true
                        }
                        
                        
                    } else {
                        
                        self.showSearchResult = false
                        
                    }
                    self.showProgressView = false
                }
            }
        }
        
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
        
        
        func isValid() -> Bool {
            
            let stringTemp = searchText
            
            if stringTemp.isNotEmpty() {
                
                return true
                
            } else {
                searchText = ""
                return false
            }
        }
        
        func onViewAppear() {
            searchText = ""
            showProgressView = false
            showFetchError = false
            showSingleProductView = false
            showSearchResult = false
            showNoResultMessage = false
        }
    }
    
}
