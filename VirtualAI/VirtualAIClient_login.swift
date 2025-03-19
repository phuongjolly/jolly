//
//  VirtualAIClient_user.swift
//  Jolly
//
//  Created by Tran Thien Khiem on 2025-03-19.
//

public struct LoginByTokenResponse: Codable {
    let loginByToken: AuthResponse
}

extension VirtualAIClient {
    public func loginByToken() async throws -> LoginByTokenResponse {
        let query = """
        mutation LoginMutation($id: ID!, $secretToken: String!) {
          loginByToken(id: $id, secretToken: $secretToken) {
            token
            user {
              id
              name
            }
          }
        }

        """
        
        if let userId = self.userId,
           let token = KeychainHelper.shared.retrieveToken(forKey: "secretToken"){
            
            let variables: [String: String] = [
                "id": userId,
                "secretToken": token,
            ]
            
            let response: LoginByTokenResponse = try await makeGraphQLRequest(query: query, variables: variables)
            
            // Store the token securely in the Keychain
            KeychainHelper.shared.storeToken(response.loginByToken.token, forKey: "authToken")
            KeychainHelper.shared.storeToken(response.loginByToken.user.id, forKey: "userId")
            self.token = response.loginByToken.token
            self.userId = response.loginByToken.user.id
            
            return response
        }
        
        throw RequestError.notAuthenticated
    }
}
