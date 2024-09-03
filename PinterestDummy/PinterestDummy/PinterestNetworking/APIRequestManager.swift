//
//  RequestManager.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/10/24.
//

import Foundation


open class APIRequestManager: NSObject {
    
    
    public override init() {
        super.init()
    }
    
    public enum APIResult {
        case successData(Data)
        case successArray([Dictionary<String, Any>])
        case success(Dictionary<String,Any>)
        case updateSuccess(Void)
        case deleteSucceess(Void)
        case failure(RequestError)
        case cancelled
    }
    
    public typealias ResultHandler = (APIResult) -> Void
    
    public let processingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
}


public enum RequestError {
    case invalidURL(String)
    case jsonSerializationError(String)
    case jsonContentError(String)
    case connectionError(String)
    case invalidDataError(String)
    case authenticationError(String)
    case credentialsError(String)
    case unknownHTTPError(Int)
    case invalidHTTPMethod(String)
    case saveFileError(String)
    case timeOut(String)
    case noData(String)
    case unknown(Error)
    case unmappable(String)
    case invalidRequest(String)
    case requestFailure(String)
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let message),
             .jsonSerializationError(let message),
             .jsonContentError(let message),
             .connectionError(let message),
             .invalidDataError(let message),
             .authenticationError(let message),
             .credentialsError(let message),
             .invalidHTTPMethod(let message),
             .saveFileError(let message),
             .timeOut(let message),
             .noData(let message),
             .unmappable(let message),
             .invalidRequest(let message),
             .requestFailure(let message):
            return message
        case .unknown(let error):
            return error.localizedDescription
        case .unknownHTTPError(let status):
            return "Bad HTTP status: \(status)"
        }
    }
}
