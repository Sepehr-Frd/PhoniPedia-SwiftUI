//
//  SingleProductView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/5/22.
//
import Foundation
import SwiftUI


struct SingleProductView: View {
    
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<SavedProduct>
    @StateObject var viewModel = ViewModel()
    
    let moc = SharedProperties.sharedMoc
    
    var productUrl: String
    var productDataObject: ProductDataObject
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                VStack {
                    
                    TabView {
                        
                        ForEach(productDataObject.data.phoneImages, id: \.self ) { urlString in
                            
                            let url = URL(string: urlString)
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .scaledToFit()
                                    .padding(.bottom, 50)
                                    .padding([.horizontal, .top])
                                
                            } placeholder: {
                                VStack(spacing: 20) {
                                    
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                        .padding()
                                    
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(.iconColor)
                                        .scaleEffect(4)
                                        .padding()
                                }
                            }
                            
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .background(.white)
                    .frame(maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.iconBgColor, lineWidth: 8)
                    )
                    .padding(10)
                    
                    VStack {
                        
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                viewModel.showDetailsView = true
                            } label: {
                                
                                ZStack {
                                    
                                    Color.iconBgColor
                                    
                                    HStack(alignment: .center, spacing: 30) {
                                        
                                        Text("More Info")
                                            .font(.title2)
                                        
                                        Image(systemName: "arrow.right.square")
                                            .scaleEffect(1.5)
                                    }
                                    .foregroundColor(.iconColor)
                                    .padding()
                                }
                                .frame(maxWidth: geometry.size.width * 0.5, maxHeight: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        Button {
                            if viewModel.isFavorite {
                                for item in favorites {
                                    if item.phoneName == productDataObject.data.phoneName {
                                        viewModel.removeFromFavorites(product: item)
                                    }
                                }
                            } else {
                                viewModel.addToFavorites(object: productDataObject)
                            }
                            
                            
                        } label: {
                            ZStack {
                                
                                viewModel.favoriteButtonBackground
                                
                                HStack {
                                    Text("\(viewModel.favoriteButtonText)")
                                        .font(.title2)
                                    
                                    viewModel.favoriteButtonImage
                                        .scaledToFit()
                                    
                                }
                                .foregroundColor(.favoriteButtonForeground)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("\(productDataObject.data.phoneName)")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                getProductStatus()
                viewModel.currentProduct = productDataObject
                viewModel.currentProductUrl = productUrl
            }
            
            .alert("Done!", isPresented: $viewModel.showSuccessMessage) {
                
            } message: {
                Text(viewModel.successMessageText)
                    .font(.title)
            }
            .alert("Error", isPresented: $viewModel.showCoreDataError) {
                
            } message: {
                Text("Something went wrong! Please try again.")
            }
            
            
            NavigationLink(isActive: $viewModel.showDetailsView) {
                
                NavigationLazyView(DetailsView(productDataObject: productDataObject))
                
            } label: {
                EmptyView()
            }
        }
        
    }
    
    func getProductStatus() {
        
        for item in favorites {
            if item.phoneName == productDataObject.data.phoneName {
                viewModel.presentRemoveButton()
                return
            }
        }
        viewModel.presentAddButton()
    }
    
    
}

struct SingleProductView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SingleProductView(productUrl: mockupData.url, productDataObject: mockupData.productObject)
            
        }
    }
}
