//
//  ContentView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/2/22.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack(spacing: 10) {
                        
                        NavigationLink (destination: FavoritesView()) {
                            SquareIcon(imageName: "bookmark", cornerRadius: 10, geometry: geometry)
                        }
                        
                        
                        Spacer()
                        
                        NavigationLink (destination: SearchView()) {
                            SquareIcon(imageName: "magnifyingglass", cornerRadius: 10, geometry: geometry)
                        }
                        
                        
                        NavigationLink (destination: BrandsView()) {
                            SquareIcon(imageName: "list.bullet", cornerRadius: 10, geometry: geometry)
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    
                    ScrollView {
                        
                        ForEach(DataSet.specialFilters) { item in
                            
                            Button {
                                viewModel.showProgressView = true
                                viewModel.selectedSlug = item.slug
                                DispatchQueue.global(qos: .default).async {
                                    
                                    viewModel.fetchSpecialDataObject(slug: item.slug)
                                }
                                
                            } label: {
                                
                                ZStack {
                                    
                                    item.image
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    
                                    Text(item.name)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.darkBgColor)
                                        .font(.largeTitle)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.75)
                        
                    }
                    .padding(.top, 10)
                }
                .alert("Fetch Error!", isPresented: $viewModel.showFetchError) {
                    
                } message: {
                    Text("Sorry, couldn't fetch data from the server")
                }
                
                
                NavigationLink(isActive: $viewModel.showFiltersView) {
                    
                    NavigationLazyView(SpecialFilterView(specialDataObject: viewModel.specialDataObject, filterSlug: viewModel.selectedSlug))
                    
                } label: {
                    EmptyView()
                }
                
                if viewModel.showProgressView {
                    CustomProgressView(size: 4)
                }
                
            }
            .navigationTitle("PhoniPedia")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
