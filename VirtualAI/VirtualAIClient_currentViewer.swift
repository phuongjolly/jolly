//
//  VirtualAIClient_user.swift
//  Jolly
//
//  Created by Tran Thien Khiem on 2025-03-19.
//

struct CurrentViewerQueryResponse: Decodable {
    let viewer: User?
}


extension VirtualAIClient {
    public func currentViewer() async throws -> User?{
        let query = """
        query CurrentViewerQuery{
            viewer {
              id
              name
            }
        }
        """
        
        let variables: [String:String] = [:]
        let response: CurrentViewerQueryResponse = try await makeGraphQLRequest(query: query, variables: variables)
        
        return response.viewer
    }
}
