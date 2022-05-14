//
//  ProductsView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import SwiftUI


struct ProductsView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var brandDataObject: BrandDataObject
    
    private var phones: [Phone] {
        brandDataObject.data.phones
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(phones, id: \.slug) { phone in
                            
                            Button {
                                
                                viewModel.phoneUrl = phone.detail
                                
                                viewModel.showProgressView = true
                                
                                DispatchQueue.global(qos: .default).async {
                                    viewModel.fetchProductDataObject(url: phone.detail)
                                }
                                
                            } label: {
                                
                                HStack {
                                    
                                    AsyncImage(url: URL(string: phone.image)) { image in
                                        image
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .scaledToFit()
                                            .padding(10)
                                        
                                        
                                    } placeholder: {
                                        
                                        VStack(spacing: 20) {
                                            
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                    }
                                    
                                    Text(phone.name)
                                        .font(.title)
                                        .foregroundColor(.darkBlueColor)
                                        .padding()
                                        .frame(width: geometry.size.width * 0.6)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(height: 150)
                        .background(.white.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.iconBgColor, lineWidth: 3)
                        )
                    }
                    .padding(.horizontal, 10)
                }
            }
            .navigationTitle(phones[0].brand)
            .navigationBarTitleDisplayMode(.inline)
            
            if viewModel.showProgressView {
                CustomProgressView(size: 4)
            }
            
            
            
                NavigationLink(isActive: $viewModel.showSingleProductView) {
                    
                    NavigationLazyView(SingleProductView(productUrl: viewModel.phoneUrl, productDataObject: viewModel.productDataObject))
                    
                } label: {
                    EmptyView()
                }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductsView(brandDataObject: Bundle.main.decode("ApplePhones.json"))
                        
        }
    }
}
