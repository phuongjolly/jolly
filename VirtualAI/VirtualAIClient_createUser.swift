//
//  VirtualAIClient_user.swift
//  Jolly
//
//  Created by Tran Thien Khiem on 2025-03-19.
//

public struct User: Codable {
    let id: String
    let name: String
}

public struct AuthResponse: Codable {
    let token: String
    let user: User
}

public struct CreateUserResponse: Codable {
    let createUser: AuthResponse
}

extension VirtualAIClient {
    public func createUser(name: String) async throws -> CreateUserResponse {
        let secretToken = UUID().uuidString + UUID().uuidString
        
        let query = """
        mutation CreateUser($name: String!, $secretToken: String!) {
          createUser(name: $name, secretToken: $secretToken) {
            token
            user {
              id
              name
            }
          }
        }
        """
        
        let variables: [String: String] = [
            "name": name,
            "secretToken": secretToken,
        ]
    
        let response: CreateUserResponse = try await makeGraphQLRequest(query: query, variables: variables)
        
        // Store the token securely in the Keychain
        KeychainHelper.shared.storeToken(secretToken, forKey: "secretToken")
        KeychainHelper.shared.storeToken(response.createUser.token, forKey: "authToken")
        KeychainHelper.shared.storeToken(response.createUser.user.id, forKey: "userId")
        self.token = response.createUser.token
        self.userId = response.createUser.user.id
        
        return response
    }
}
