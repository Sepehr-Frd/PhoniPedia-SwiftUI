//
//  HomeView-ViewModel.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//
import CoreData
import Foundation
import SwiftUI

extension HomeView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var showFetchError = false
        @Published var showProgressView = false
        @Published var showFiltersView = false
        @Published var selectedSlug = ""
        
        private let specialFilterApi = SpecialFiltersApi()
        
        var specialDataObject: SpecialDataObject!
        
        func fetchSpecialDataObject(slug: String) {
            
            specialFilterApi.getSpecialFiltersAlamofire(filterSlug: slug) { [weak self] dataObject in
                guard let self = self else {
                    self?.showFetchError = true
                    self?.showProgressView = false
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let object = dataObject {
                        
                        self.specialDataObject = object
                        self.showFiltersView = true
                        
                        
                    } else {
                        
                        self.showFetchError = true
                        
                    }
                    self.showProgressView = false
                    
                }
            }
        }
    }
}

