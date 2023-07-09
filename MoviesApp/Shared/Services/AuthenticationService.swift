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
    
    @AppStorage(UserDefaultsKeys.EXPIRATION_DATE) var expirationDateDate : String = ""
    @AppStorage(UserDefaultsKeys.REQUEST_TOKEN) var request_token = ""
    @AppStorage(UserDefaultsKeys.SESSION_ID) var sessionID = ""
    
    func login(with userName : String , and password:String) -> AnyPublisher<Bool,Error> {
        
        guard let url = movieDBURL.login.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.methodWithBody(methodType: "POST", url: url, requestBody: LoginRequest(username: userName, password: password, requestToken: APIAuth.requestToken), response: RequestTokenResponse.self)
            .map { [weak self] requestTokenResponse in
                self?.expirationDateDate = requestTokenResponse.expiresAt
                self?.request_token = requestTokenResponse.requestToken
                return requestTokenResponse.success
            }
            .eraseToAnyPublisher()
    }
    
    func createSessionID() -> AnyPublisher<Bool,Error> {
        guard  let url = movieDBURL.requestSession.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.methodWithBody(methodType: "POST", url: url, requestBody: CreateSessionRequest(requestToken: APIAuth.requestToken), response: RequestSessionIDResponse.self)
            .map { [weak self] response in
                    self?.sessionID  = response.sessionID ?? ""
                    print("\(self?.sessionID) success")
                    return !((response.sessionID?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) == nil)
                }
                .eraseToAnyPublisher()
    }
    
    
    func requestToken() -> AnyPublisher<Bool,Error> {
        guard let url = movieDBURL.requestToken.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        
        return GenricServiceMethods.shared.getMethod(url: url, response: RequestTokenResponse.self)
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
        
        return GenricServiceMethods.shared.methodWithBody(methodType: "DELETE", url: url, requestBody: LogoutRequest(sessionID: APIAuth.requestToken), response: RequestSessionIDResponse.self)
                .map { [weak self] response in
                        
                    self?.expirationDateDate = ""
                    self?.request_token = ""
                    self?.sessionID = ""
                    
                    return response.success
                }
                .eraseToAnyPublisher()
    }
    
}
