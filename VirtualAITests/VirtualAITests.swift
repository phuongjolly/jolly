//
//  VirtualAITests.swift
//  VirtualAITests
//
//  Created by Tran Thien Khiem on 2025-03-19.
//

import Testing
@testable import VirtualAI

struct VirtualAITests {
    let client = VirtualAIClient(endpoint: "http://localhost:3000/graphql")

    @Test func createUser() async throws {
        do {
            let response = try await client.createUser(name: "Khiem")
            
            print(response)
        } catch {
            print(error)
        }
    }
    
    @Test func login() async throws {
        do {
            let response = try await client.loginByToken()
            
            print(response)
        } catch {
            print(error)
        }
    }
    
    @Test func currentViewer() async throws {
        do {
            let currentViewer = try await client.currentViewer()
            
            print(currentViewer!)
        } catch {
            print(error)
        }
    }

}
