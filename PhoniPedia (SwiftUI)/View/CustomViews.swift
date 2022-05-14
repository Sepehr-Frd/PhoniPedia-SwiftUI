//
//  CustomViews.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import Foundation
import SwiftUI


struct SquareIcon: View {
    
    let imageName: String
    let cornerRadius: CGFloat
    let geometry: GeometryProxy
    
    
    var body: some View {
        
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .foregroundColor(.iconColor)
            .padding(8)
            .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
            .background(.iconBgColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        
    }
}


struct SpecialFilterViewVStack: View {
    
    let phone: SpecialPhone
    let filterSlug: String
    let hits: Int
    let favorites: Int
    let image: Image
    
    var topByInterestText: String {
        hits == 0 ? "N/A" : "\(hits)"
    }
    
    var topByFansText: String {
        favorites == 0 ? "N/A" : "\(favorites)"
    }
    
    init(phone: SpecialPhone, slug: String) {
        
        if let hits = phone.hits {
            
            self.hits = hits
            self.favorites = 0
            image = Image(systemName: "iphone")
            
        } else if let favorites = phone.favorites {
            self.hits = 0
            self.favorites = favorites
            image = Image(systemName: "iphone")
        } else {
            
            favorites = 0
            hits = 0
            image = Image(systemName: "iphone")
                .data(url: phone.image)
        }
        
        filterSlug = slug
        
        self.phone = phone
        
        
    }
    
    var body: some View {
        
        switch filterSlug {
            
        case "top-by-interest":
            
            VStack {
                
                Text("Views: \(topByInterestText)")
                    .padding(5)
                    .font(.title3)
                
                if hits > 15000 {
                    Text("🔥")
                        .padding(5)
                        .font(.largeTitle)
                }
            }
            
        case "top-by-fans":
            
            VStack {
                
                Text("Likes: \(topByFansText)")
                    .padding(5)
                    .font(.title3)
                
                if favorites > 1000 {
                    Text("👍🏻")
                        .padding(5)
                        .font(.largeTitle)
                }
            }
            
        case "latest":
            
            image
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        default:
            Text("Something went wrong!")
            
        }
    }
}


struct CustomProgressView: View {
    
    let size: CGFloat
    
    var body: some View {
        
        ZStack {
            
            Color.darkBgColor
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.white)
                .scaleEffect(size)
            
        }
        
    }
}


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}




