//
//  GenricServiceMethods.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import Foundation
import Combine


class GenricServiceMethods  {
    
    static let shared = GenricServiceMethods()
    
    private init() { }
    
    func getMethod<T : Codable>(url:URL , response : T.Type) -> AnyPublisher<T,Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{
//                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }

    func methodWithBody<T1 : Codable , T2 : Codable>(methodType : String ,url : URL , requestBody : T1 ,  response : T2.Type)  -> AnyPublisher<T2,Error> {
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = methodType
            let encoder = JSONEncoder()
            let body = requestBody
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T2.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
            
        }catch {
            return Fail<T2,Error>(error: error)
                .eraseToAnyPublisher()
        }

    }
}
