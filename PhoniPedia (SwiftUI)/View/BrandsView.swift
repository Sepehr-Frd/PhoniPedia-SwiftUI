//
//  BrandsView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import SwiftUI

struct BrandsView: View {
    
    
    
    @StateObject private var viewModel = ViewModel()
    
    private let gridItems = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    LazyVGrid(columns: gridItems) {
                        
                        ForEach(DataSet.brands) { brand in
                            
                            Button {
                                
                                viewModel.showProgressView = true
                                
                                DispatchQueue.global(qos: .default).async {
                                    
                                    viewModel.fetchBrandDataObject(brandSlug: brand.slug)
                                }
                                
                                
                            } label: {
                                ZStack {
                                    Color(.white)
                                        .scaledToFill()
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .strokeBorder(.iconBgColor, lineWidth: 5)
                                        )
                                    
                                    brand.image
                                        .resizable()
                                        .padding()
                                    
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    
                }
            }
            .navigationTitle("Brands")
            .navigationBarTitleDisplayMode(.inline)
            
            NavigationLink(isActive: $viewModel.showProductsView) {
                
                NavigationLazyView(ProductsView(brandDataObject: viewModel.brandDataObject))
                
            } label: {
                EmptyView()
            }
            
            .alert("Fetch Error!", isPresented: $viewModel.showFetchError) {
                
            } message: {
                Text(SharedProperties.fetchErrorText)
            }
            
            if viewModel.showProgressView {
                
                CustomProgressView(size: 4)
            }
        }
    }
}


struct BrandsView_Previews: PreviewProvider {
    static var previews: some View {
        BrandsView()
        
    }
}
