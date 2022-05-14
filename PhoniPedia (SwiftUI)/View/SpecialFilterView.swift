//
//  SpecialFilterView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import SwiftUI

struct SpecialFilterView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var specialDataObject: SpecialDataObject
    
    var filterSlug: String
    
    private let gridItems = [GridItem(.adaptive(minimum: 300))]
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                
                ScrollView {
                    
                    LazyVGrid(columns: gridItems) {
                        
                        ForEach(specialDataObject.data.phones, id: \.slug) { phone in
                            
                            Button {
                                
                                viewModel.showProgressView = true
                                DispatchQueue.global(qos: .default).async {
                                    viewModel.fetchProductDataObject(url: phone.detail)
                                }
                                
                                
                            } label: {
                                
                                HStack {
                                    
                                    Text(phone.name)
                                        .font(.title)
                                        .padding()
                                        .frame(maxWidth: geometry.size.width * 0.5)
                                        .foregroundColor(.darkBlueColor)
                                    
                                    Spacer()
                                    
                                    SpecialFilterViewVStack(phone: phone, slug: filterSlug)
                                        .padding(5)
                                        .foregroundColor(.darkBlueColor)
                                    
                                }
                                
                            }
                            
                        }
                        .alert("Fetch Error!", isPresented: $viewModel.showFetchError) {
                            
                        } message: {
                            Text("Something went wrong! Please try again.")
                        }
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.iconBgColor, lineWidth: 3)
                        )
                        
                    }
                    
                    .padding(10)
                }
                

                NavigationLink(isActive: $viewModel.showSingleProductView) {
                    
                    NavigationLazyView(SingleProductView(productUrl: viewModel.productUrl, productDataObject: viewModel.productDataObject))
                    
                } label: {
                    EmptyView()
                }
                
                
                
                
                if viewModel.showProgressView {
                    CustomProgressView(size: 4)
                }
                
            }
            
        }
        .navigationTitle("ProductsView")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct SpecialFilterView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SpecialFilterView(specialDataObject: mockupData.latestObject, filterSlug: "latest")
        }
    }
}
