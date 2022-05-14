import Foundation
import Alamofire

class ProductApi {
    
    func getProductAlamofire(url: String, completion: @escaping ProductResponseCompletion) {
        
        AF.request(url).response { response in
            
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
                let brandObject = try JSONDecoder().decode(ProductDataObject.self, from: data)
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
