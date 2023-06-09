//
//  Router.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import Foundation

enum APIError: Error {
    case parsingError
    case requestFailed(String)
    case invalidResponse
    case requestError(Error)
}

class Router {
    let baseURL: URL
    
    init() {
        self.baseURL = URL(string: Constants.baseURL)!
    }
    func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "access_key", value: Constants.access_key))
        for itemvalue in endpoint.parameters {
            queryItems.append(URLQueryItem(name: itemvalue.key, value: itemvalue.value))
        }
        urlComponents?.queryItems = queryItems

        
        guard let url = urlComponents?.url else {
            fatalError("Failed to create the URL.")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
      
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(APIError.requestError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let responseData = data {
                    let jsonString = String(data: responseData, encoding: .utf8)
                    print("Response JSON: \(jsonString ?? "")")
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let dto = try decoder.decode(T.self, from: responseData)
                        completion(.success(dto))
                    } catch {
                        do {
                            let decoder = JSONDecoder()
                            let dto = try decoder.decode(T.self, from: responseData)
                            completion(.success(dto))
                        }
                        catch {
                            completion(.failure(APIError.parsingError))

                        }
                                    
                    }
                } else {
                    completion(.failure(APIError.invalidResponse))
                }
            }
        }
        task.resume()
    }
}
