import Foundation
import Alamofire

class SpecialFiltersApi {
    
    func getSpecialFiltersAlamofire(filterSlug: String, completion: @escaping SpecialFiltersResponseCompletion) {
        
        let url = "\(SharedProperties.baseUrl)\(filterSlug)"
        
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
                let brandObject = try JSONDecoder().decode(SpecialDataObject.self, from: data)
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

