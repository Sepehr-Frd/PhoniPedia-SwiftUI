//
//  SearchView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import SwiftUI

struct SearchView: View {
    
    @FocusState private var isTyping: Bool
    @StateObject private var viewModel = ViewModel()
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.iconColor
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack(alignment: .center, spacing: 5) {
                        
                        HStack(alignment: .center, spacing: 5) {
                            
                            Image(systemName: "magnifyingglass")
                                .padding([.leading, .vertical], 10)
                                .animation(.default, value: isTyping)
                            
                            TextField("Search for devices", text: $viewModel.searchText)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .focused($isTyping)
                                .foregroundColor(.black)
                                .onSubmit {
                                    
                                    isTyping = false
                                    
                                    if viewModel.isValid() {
                                        
                                        viewModel.showProgressView = true
                                        DispatchQueue.global(qos: .default).async {
                                            viewModel.fetchSearchResult()
                                        }
                                    }
                                }
                            
                        }
                        .frame(maxHeight: .infinity)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Button {
                            
                            isTyping = false
                            
                            if viewModel.isValid() {
                                
                                viewModel.showProgressView = true
                                DispatchQueue.global(qos: .default).async {
                                    viewModel.fetchSearchResult()
                                }
                                
                            }
                            
                        } label: {
                            
                            ZStack {
                                Color.iconBgColor
                                Text("Search")
                                    .font(.body.bold())
                                    .foregroundColor(.iconColor)
                            }
                        }
                        .frame(maxWidth: geometry.size.width * 0.25)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 5)
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
                    
                    Spacer()
                    
                    VStack {
                        
                        if viewModel.showSearchResult {
                            
                            ScrollView {
                                
                                LazyVStack {
                                    
                                    ForEach(viewModel.searchResult.data.phones, id: \.slug) { phone in
                                        
                                        Button {
                                            
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
                        } else if viewModel.showNoResultMessage {
                            
                            Text(viewModel.noResultMessage)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(.iconBgColor.opacity(0.75))
                                .foregroundColor(.iconColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                    .onTapGesture {
                        isTyping = false
                    }
                }
                .alert("Fetch Error!", isPresented: $viewModel.showFetchError) {
                    Text(SharedProperties.fetchErrorText)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done"){
                            isTyping = false
                        }
                    }
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
            .onAppear {
                
                viewModel.onViewAppear()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isTyping = true
                } 
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
                
        }
        
    }
}
