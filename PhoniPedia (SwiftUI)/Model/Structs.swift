// **** Structures for all application classifications **** //

import Foundation
import SwiftUI


//MARK: - Brand Structure

struct Brand: Identifiable {
    let id = UUID()
    let name: String
    let slug: String
    let image: Image
}

//MARK: - Special Filters Structure
struct SpecialFilters: Identifiable {
    let id = UUID()
    let name: String
    let slug: String
    let image: Image
}


//MARK: - Single Product Structure

struct ProductDataObject: Codable {
    let data: ProductDetailsList
}

struct ProductDetailsList: Codable {
    let brand: String
    let phoneName: String
    let phoneImages: [String]
    let thumbnail: String
    let releaseDate: String
    let os: String
    let specifications: [Specification]
    
    enum CodingKeys: String, CodingKey {
        case brand
        case phoneName = "phone_name"
        case phoneImages = "phone_images"
        case releaseDate = "release_date"
        case os
        case thumbnail
        case specifications
    }
}

struct Specification: Codable {
    let title: String
    let specs: [Spec]
}


struct Spec: Codable {
    let key: String
    let val: [String]
}




//MARK: - Brand Items List Struct

struct BrandDataObject: Codable {
    let data: BrandItemsList
}

struct BrandItemsList: Codable {
    let title: String
    let phones: [Phone]
    
}

struct Phone: Codable {
    let brand: String
    let name: String
    let slug: String
    let image: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case brand
        case name = "phone_name"
        case slug
        case image
        case detail
    }
}


//MARK: - Special Filters Data Object


struct SpecialDataObject: Codable {
    let data: SpecialList
}
struct SpecialList: Codable {
    let title: String
    let phones: [SpecialPhone]
}

struct SpecialPhone: Codable {
    let name: String
    let slug: String
    let detail: String
    var favorites: Int?
    var image: String?
    var hits: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "phone_name"
        case slug
        case detail
        case favorites
        case image
        case hits
        
    }
    
}

