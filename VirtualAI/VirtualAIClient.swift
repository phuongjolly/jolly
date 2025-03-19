//
//  VirtualAIClient.swift
//  Jolly
//
//  Created by Tran Thien Khiem on 2025-03-19.
//

import Foundation

public enum RequestError: Error {
    case encodingError
    case invalidURL
    case decodingError
    case noResponse
    case notAuthenticated
}

struct GraphQLRequest<VariableType: Encodable>: Encodable {
    let query: String
    let variables: VariableType
}

struct GraphQLResponse<Response: Decodable>: Decodable {
    let data: Response?
}

public class VirtualAIClient {
    
    let endpoint: String
    var token: String?
    public var userId: String?
    
    public init(endpoint: String) {
        self.endpoint = endpoint
        
        token = KeychainHelper.shared.retrieveToken(forKey: "authToken")
        userId = KeychainHelper.shared.retrieveToken(forKey: "userId")
    }
    
    public func makeGraphQLRequest<Variables: Encodable, Response: Decodable>(
        query: String,
        variables: Variables
    ) async throws -> Response {
        let response: GraphQLResponse<Response> = try await makePostRequest(
            requestBody: GraphQLRequest(query: query, variables: variables)
        )
        
        if let data = response.data {
            return data
        }
        
        throw RequestError.noResponse
    }
    
    // Generic function to make a POST request using async/await
    public func makePostRequest<Request: Encodable, Response: Decodable>(
        requestBody: Request
    ) async throws -> Response {
        // Serialize the Request to JSON
        guard let jsonData = try? JSONEncoder().encode(requestBody) else {
            throw RequestError.encodingError
        }
        
        // Set up the URL and request
        guard let url = URL(string: endpoint) else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Make the network request
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode the response to the generic Response type
        do {
            print("Data: \(String(data: data, encoding: .utf8)!)")
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            return decodedResponse
        } catch {
            throw RequestError.decodingError
        }
    }
    

}
