//
//  PinsService.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/12/24.
//

import Foundation
import Combine

public protocol PinsService {
    func fetchPins(pageNo: Int) -> AnyPublisher<[Pin], Error>
}


public class PinsNetworkService: PinsService {
    
    public func fetchPins(pageNo: Int) -> AnyPublisher<[Pin], any Error> {
        guard let urlRequest = PinsEndpoint.init(path: "/v2/anime/\(pageNo)").request else {
            return Fail(error: RequestError.invalidURL("Please check URL"))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({(data, response) -> Data in
                    do {
                        if let data = try JSONSerialization.jsonObject(with: data) as? [String: Any], let results = data["results"] {
                            let resultData = try JSONSerialization.data(withJSONObject: results, options: [])
                            return resultData
                            
                        }
                    } catch {
                        throw URLError(.cannotParseResponse)
                    }
              
                throw URLError(.cannotParseResponse)
                
            })
            .decode(type: [Pin].self, decoder: JSONDecoder())
            .mapError({ error -> Error in
                print("Errpr: \(error)")
                return error
            })
            .eraseToAnyPublisher()
    }
    
    
}
