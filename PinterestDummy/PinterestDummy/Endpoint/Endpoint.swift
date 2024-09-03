//
//  Endpoint.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/12/24.
//

import Foundation
import Combine

public enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case HEAD
    case DELETE
}

enum HttpRequestHeaderKey: String {
    case x_csrf_Token = "X-CSRF-Token"
    case x_http_method = "x-http-method"
    case x_sup_sc = "X-SUP-SC"
    case x_requested_with = "X-Requested-With"
    case content_type = "Content-Type"
    case accept = "accept"
    case clientName = "Client-Name"
    case authorization = "authorization"
    case x_rapidapi_key = "x-rapidapi-key"

}


/// Function type, accepts `Endpoint` as parameter and returns  one-time publisher of the result of the fetch
typealias Networking = (Endpoint) -> Future<Data, Error>

/**
 An `Endpoint` is a representation of an API, and can easily be turned into a `URL`
 */
protocol Endpoint {
    /// Host - for example `sap.com`
    var host: String { get }
    /// Path - for example: `/building/23/blabla`
    var path: String { get }
    /// Query items, like `?active=true`
    var queryItems: [URLQueryItem] { get }

    var httpMethod: HttpMethod { get set }

    /// The `URL` corresponding to our `Endpoint`.
    /// Could be nil as there can be invalid characters in the path or query items
    /// - important: URL scheme defaults to `https`
    var url: URL? { get }

    var request: URLRequest? { get }

    var httpHeaders: [(key: HttpRequestHeaderKey, value: String)]? { get set }

    var body: Data? { get set }
}

extension Endpoint {

    static var defaultHeaders: [(key: HttpRequestHeaderKey, value: String)] {
        return [(key: .content_type, value: "application/json"),
                (key: .accept, value: "application/json"),
                (key: .x_rapidapi_key, value: "b70ca0bf1cmsh5347b030989102ap1ab5cfjsnd3c26ca49a1a")]
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.host
        components.path = self.path
        if !queryItems.isEmpty {
            components.queryItems = self.queryItems
        }

        return components.url
    }

    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod  = self.httpMethod.rawValue

        if let httpHeaders = httpHeaders {
            httpHeaders.forEach { (header) in
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
            }
        }
        if let body = body {
            urlRequest.httpBody = body
        }
        return urlRequest
    }
}
