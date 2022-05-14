import Foundation
import Alamofire

class SearchApi {
    
    func searchWithNameAlamofire(phoneName: String, completion: @escaping BrandResponseCompletion) {
        
        let stringUrl = "\(SharedProperties.searchUrl)\(phoneName)"
        
        guard let url = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        
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
