//
//  AuthenticationService.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import Foundation
import Combine
import SwiftUI

class AuthenticationService {
    
    @AppStorage("expiration_date") var expirationDateDate : String = ""
    @AppStorage("request_token") var  request_token = ""
    @AppStorage("session_id") var sessionID = ""
    
    func login(with userName : String , and password:String) -> AnyPublisher<Bool,Error> {
        
        
        guard let url = movieDBURL.login.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = LoginRequest(username: userName, password: password, requestToken: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map{
                    print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                    return $0.data
                }
                .decode(type: RequestTokenResponse.self, decoder: JSONDecoder())
                .map { [weak self] requestTokenResponse in
                    self?.expirationDateDate = requestTokenResponse.expiresAt 
                    self?.request_token = requestTokenResponse.requestToken
                    return requestTokenResponse.success
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail<Bool,Error>(error: error)
                .eraseToAnyPublisher()
        }
        
    }
    
    func createSessionID() -> AnyPublisher<Bool,Error> {
        guard  let url = movieDBURL.requestSession.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = CreateSessionRequest(requestToken: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map{
                    print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                    return $0.data
                }
                .decode(type: RequestSessionIDResponse.self, decoder: JSONDecoder())
                .map { [weak self] response in
                    self?.sessionID  = response.sessionID ?? ""
                    print("\(self?.sessionID) success")
                    return !((response.sessionID?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) == nil)
                }
                .eraseToAnyPublisher()
        }catch {
            return Fail<Bool,Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    
    func requestToken() -> AnyPublisher<Bool,Error> {
        guard let url = movieDBURL.requestToken.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{
                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
            .decode(type: RequestTokenResponse.self, decoder: JSONDecoder())
            .map { [weak self] response in
                self?.request_token = response.requestToken
                return !(response.requestToken.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Bool,Error> {
        
        guard  let url = movieDBURL.deleteSession.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let encoder = JSONEncoder()
            let body = LogoutRequest(sessionID: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map{
                    print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                    return $0.data
                }
                .decode(type: RequestSessionIDResponse.self, decoder: JSONDecoder())
                
                .map { [weak self] response in
                        
                    self?.expirationDateDate = ""
                    self?.request_token = ""
                    self?.sessionID = ""
                    
                    return response.success
                }
                .eraseToAnyPublisher()
            
            
            
        }catch {
            return Fail<Bool,Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
    
}
