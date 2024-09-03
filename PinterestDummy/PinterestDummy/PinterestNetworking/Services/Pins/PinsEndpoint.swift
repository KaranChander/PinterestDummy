//
//  PinsEndpoint.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/12/24.
//

import Foundation


struct PinsEndpoint: Endpoint {
    var host: String
    
    var path: String
    
    var queryItems: [URLQueryItem]
    
    var httpMethod: HttpMethod
    
    var httpHeaders: [(key: HttpRequestHeaderKey, value: String)]?
    
    var body: Data?
    
    
    init(host: String = "free-images-api.p.rapidapi.com", path: String, queryItems: [URLQueryItem] = [], httpMethod: HttpMethod = .GET, httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? = PinsEndpoint.defaultHeaders, body: Data? = nil) {
        self.host = host
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.body = body
    }
    
}
