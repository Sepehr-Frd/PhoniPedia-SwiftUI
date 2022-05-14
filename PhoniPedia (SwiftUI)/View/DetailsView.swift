//
//  DetailsView.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/6/22.
//

import SwiftUI

struct DetailsView: View {
    
    var productDataObject: ProductDataObject
    
    var body: some View {
        
        ZStack {
            
            Color.iconColor
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                    ZStack {
                        
                        Color.white
                            .opacity(0.3)
                        
                        VStack {
                            ForEach(productDataObject.data.specifications, id: \.title) { item in
                                
                                Text("\(item.title)")
                                    .font(.largeTitle)
                                    .padding()
                                
                                Spacer()
                                
                                VStack  {
                                    
                                    ForEach(item.specs, id: \.key) { subItem in
                                        
                                        HStack(spacing: 5) {
                                            
                                            Text("\(subItem.key) :")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20).bold())
                                                .multilineTextAlignment(TextAlignment.center)
                                            
                                            Spacer()
                                            
                                            ForEach(subItem.val, id: \.self) { val in
                                                
                                                Text(val)
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.iconColor)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(10)
                                        .background(.iconBgColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                        }
                        .padding(10)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(5)
            }
        }
        .navigationTitle("\(productDataObject.data.phoneName) Specifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(productDataObject: mockupData.productObject)
                
        }
    }
}
