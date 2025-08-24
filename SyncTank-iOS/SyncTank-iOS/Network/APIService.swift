//
//  APIService.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    func saveDocs(_ item: DashItemRequest) async throws -> String {
        let url = API.baseURL.appendingPathComponent(API.Path.saveDocs)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try encoder.encode(item)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            return String(data: data, encoding: .utf8) ?? "Success"
        case 422:
            throw APIError.validation("Validation failed: \(String(data: data, encoding: .utf8) ?? "")")
        default:
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
    }
    
    func fetchDocs() async throws -> [DashItem] {
        let url = API.baseURL.appendingPathComponent(API.Path.fetchDocs)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    return try decoder.decode([DashItem].self, from: data)
                } catch {
                    print(error)
                    throw APIError.decoding("Failed to decode response: \(error)")
                }
                
            case 400..<500:
                throw APIError.clientError(statusCode: httpResponse.statusCode)
                
            case 500..<600:
                throw APIError.serverError(statusCode: httpResponse.statusCode)
                
            default:
                throw APIError.httpError(statusCode: httpResponse.statusCode)
            }
            
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.network("Unexpected error: \(error.localizedDescription)")
        }
    }
}
