//
//  Extensions.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//

import Foundation
import SwiftUI



extension Image {
    
    static let appleImg = Image("Apple")
    static let asusImg = Image("Asus")
    static let blackberryImg = Image("Blackberry")
    static let dellImg = Image("Dell")
    static let hpImg = Image("HP")
    static let htcImg = Image("HTC")
    static let huaweiImg = Image("Huawei")
    static let lenovoImg = Image("Lenovo")
    static let lgImg = Image("LG")
    static let microsoftImg = Image("Microsoft")
    static let motorolaImg = Image("Motorola")
    static let nokiaImg = Image("Nokia")
    static let samsungImg = Image("Samsung")
    static let googleImg = Image("Google")
    static let sonyImg = Image("Sony")
    static let xiaomiImg = Image("Xiaomi")
    static let topByInterest = Image("topByInterest")
    static let topByFans = Image("topByFans")
    static let latest = Image("latest")
    
    func data(url: String?) -> Self {
        
        guard let string = url else { return self }
        
        guard let url = URL(string: string) else { return self }
        
        if let data = try? Data(contentsOf: url) {
            
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
            
        }
        
        return self
            .resizable()
        
    }

}

extension ShapeStyle where Self == Color {
    
    static var iconColor: Color {
        Color("iconColor")
    }
    static var iconBgColor: Color {
        Color("iconBackgroundColor")
    }
    static var darkBgColor: Color {
        Color("darkBackgroundColor")
    }
    static var favoriteButtonBackground: Color {
        Color("favoriteBackgroundColor")
    }
    static var removeButtonBackground: Color {
        Color("removeBackgroundColor")
    }
    static var favoriteButtonForeground: Color {
        Color("favoriteForegroundColor")
    }
    
    static var darkBlueColor: Color {
        Color("darkBlueColor")
    }
    
    static var lightBlueColor: Color {
        Color("lightBlueColor")
    }
    
    
      
}


extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}

extension String {

    func isNotEmpty() -> Bool {
        return !(self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

}








