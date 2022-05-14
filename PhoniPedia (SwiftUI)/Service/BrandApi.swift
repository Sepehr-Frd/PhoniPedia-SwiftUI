import Foundation
import Alamofire

class BrandApi {
    
    func getBrandAlamofire(brandSlug: String, completion: @escaping BrandResponseCompletion) {
        
        AF.request("\(SharedProperties.baseBrandUrl)\(brandSlug)").response { response in
            
            
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let brandObject = try JSONDecoder().decode(BrandDataObject.self, from: data)
                completion(brandObject)
                return
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
        }
    }
}





