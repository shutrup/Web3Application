//
//  Request.swift
//  DGUNH
//
//  Created by timur on 17.05.2023.
//

import Foundation

class BaseRequest {
    private var boundaryString: String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func sendRequest<T: Decodable> (endpoint: Endpoint, responseModel: T.Type, urlEncoded: Bool = false) async ->  Result<T, RequestError> {
        guard let url = URL(string: API.baseUrl + endpoint.path) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.parameters {
            switch endpoint.method {
            case.get:
                var urlComponents = URLComponents(string: API.baseUrl + endpoint.path)
                urlComponents?.queryItems = body.map({ URLQueryItem(name: $0.key, value: "\($0.value)")})
                request.url = body.count > 0 ? urlComponents?.url : URL(string: API.baseUrl + endpoint.path)
            case.post, .put, .delete, .patch:
                if urlEncoded {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    let postData = body.percentEncoded()
                    request.httpBody = postData
                } else {
                    request.httpBody = RequestEncoder.json(parameters: body)
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                }
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unexpectedStatusCode)
            default:
                guard let decodedResponse = try? JSONDecoder().decode(String.self, from: data) else {
                    return .failure(.unexpectedStatusCode)
                }
                
                print(decodedResponse)
                return.failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
