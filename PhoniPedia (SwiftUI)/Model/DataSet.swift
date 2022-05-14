//***** Dataset for predefined information ******//

import Foundation
import SwiftUI

struct DataSet {
    static let brands = [
        Brand(name: "Apple", slug: "apple-phones-48" , image: Image.appleImg),
        Brand(name: "Asus" , slug: "asus-phones-46" ,image: Image.asusImg),
        Brand(name: "BlackBerry" , slug: "blackberry-phones-36" ,image: Image.blackberryImg),
        Brand(name: "Dell" , slug: "dell-phones-61" ,image: Image.dellImg),
        Brand(name: "HP" , slug: "hp-phones-41" ,image: Image.hpImg),
        Brand(name: "HTC" , slug: "htc-phones-45" ,image: Image.htcImg),
        Brand(name: "Huawei" , slug: "huawei-phones-58" ,image: Image.huaweiImg),
        Brand(name: "Lenovo" , slug: "lenovo-phones-73" ,image: Image.lenovoImg),
        Brand(name: "LG" , slug: "lg-phones-20" ,image: Image.lgImg),
        Brand(name: "Microsoft" , slug: "microsoft-phones-64" ,image: Image.microsoftImg),
        Brand(name: "Motorola" , slug: "motorola-phones-4" ,image: Image.motorolaImg),
        Brand(name: "Nokia" , slug: "nokia-phones-1" ,image: Image.nokiaImg),
        Brand(name: "Samsung" , slug: "samsung-phones-9" ,image: Image.samsungImg),
        Brand(name: "Google" , slug: "google-phones-107" ,image: Image.googleImg),
        Brand(name: "Sony" , slug: "sony-phones-7" ,image: Image.sonyImg),
        Brand(name: "Xiaomi" , slug: "xiaomi-phones-80" ,image: Image.xiaomiImg)
    ]
    
    static let specialFilters = [
        SpecialFilters(name: "Latest", slug: "latest", image: Image.latest),
        SpecialFilters(name: "Top by Interest", slug: "top-by-interest", image: Image.topByInterest),
        SpecialFilters(name: "Top by Fans", slug: "top-by-fans", image: Image.topByFans)
    ]
    
}
