//
//  Constants.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/3/22.
//
import CoreData
import Foundation


struct SharedProperties {
    
    static let baseBrandUrl = "https://api-mobilespecs.azharimm.site/v2/brands/"
    static let baseUrl = "https://api-mobilespecs.azharimm.site/v2/"
    static let searchUrl = "https://api-mobilespecs.azharimm.site/v2/search?query= "
    static let fetchErrorText = "Something went wrong! Please try again."
    static var sharedMoc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)                   
}

struct mockupData {
    
    static let brandObject: BrandDataObject = Bundle.main.decode("ApplePhones.json")
    static let productObject: ProductDataObject = Bundle.main.decode("iPhoneSE.json")
    static let searchObject: BrandDataObject = Bundle.main.decode("Search.json")
    static let latestObject: SpecialDataObject = Bundle.main.decode("Latest.json")
    static let url = mockupData.brandObject.data.phones[0].detail
    static let phoneSlug = mockupData.brandObject.data.phones[0].slug
}

//MARK: - Type Aliases

typealias ProductResponseCompletion = (ProductDataObject?) -> Void
typealias BrandResponseCompletion = (BrandDataObject?) -> Void
typealias SpecialFiltersResponseCompletion = (SpecialDataObject?) -> Void
typealias ProductFromSpecialCompletion = (ProductDataObject?) -> Void


