//
//  NetworkRequestManager.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/10/24.
//

import Foundation


class NetworkRequestManager: APIRequestManager {
    
    enum PinImagesResult {
        case success(Dictionary<String, Any>)
        case failure(RequestError)
    }
    
    typealias PinImagesCompletion = (PinImagesResult) -> Void
    
    
    private override init() {
        super.init()
    }
    
//    func fetchPinImages(completion: @escaping PinImagesCompletion) {
//        let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=10")!
//        let request = URLRequest(url: url)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(.unknown(error)))
//            }
//            
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                completion(.failure(.invalidHTTPMethod(response.debugDescription)))
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                if let jsonArray = json as? [[String: Any]] {
////                    self.completion()
//                }
//            } catch let error {
//                
//            }
//        }
//    }
}
