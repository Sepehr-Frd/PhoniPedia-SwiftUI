//
//  FavoritesView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import SwiftUI

struct FavoritesView: View {
    
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<SavedProduct>
    @StateObject private var viewModel = ViewModel()
    
    let moc = SharedProperties.sharedMoc
    
    var body: some View {
        
        GeometryReader { geometry in
            
            List {
                
                ForEach(favorites) { phone in
                    
                    Button {
                        
                        viewModel.showProgressView = true
                        
                        DispatchQueue.global(qos: .default).async {
                            viewModel.fetchProductDataObject(url: phone.phoneDetails ?? "")
                        }
                        
                    } label: {
                        
                        HStack {
                            
                            AsyncImage(url: URL(string: phone.phoneImage ?? "")) { image in
                                
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .scaledToFit()
                                
                            } placeholder: {
                                
                                VStack(spacing: 20) {
                                    
                                    Image(systemName: "iphone")
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                            Spacer()
                            
                            Text(phone.phoneName ?? "iPhone")
                            
                                .font(.title2)
                                .foregroundColor(.iconBgColor)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(5)
                    }
                    .frame(height: 150)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        
                        Button("Delete", role: .destructive) {
                            viewModel.removeFromFavorites(phone: phone)
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.removeRows(at: indexSet)
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .alert("Fetch Error!", isPresented: $viewModel.showFetchError) {
                Text("Something went wrong! Please try again.")
            }
            
            
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


struct FavoritesView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            FavoritesView()
        }
    }
}
