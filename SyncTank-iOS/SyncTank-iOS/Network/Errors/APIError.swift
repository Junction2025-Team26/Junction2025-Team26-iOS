//
//  APIError.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

enum APIError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
    case validation(String)
    
    case decoding(String)
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case network(String)
}
