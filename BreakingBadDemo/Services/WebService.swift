//
//  WebService.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import Foundation

enum WebServiceError: Error {
    
    case failedRequest
    case invalidData
    case invalidResponse
    case noData
}

class WebService {
    
    typealias CharactersCompletion = ([Character]?, WebServiceError?) -> ()

    private static let scheme = "https"
    private static let host = "breakingbadapi.com"
    
    static func requestCharacters(completion: @escaping CharactersCompletion) {
    
        var urlBuilder = URLComponents()
        urlBuilder.scheme = scheme
        urlBuilder.host = host
        urlBuilder.path = "/api/characters"
        
        guard let url = urlBuilder.url
        else {return}
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
              guard error == nil else {
                completion(nil, .failedRequest)
                return
              }

              guard let data = data else {
                completion(nil, .noData)
                return
              }

              guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
              }

              guard response.statusCode == 200 else {
                completion(nil, .failedRequest)
                return
              }

              do {
                
                let decoder = JSONDecoder()
                
                let characters = try decoder.decode([Character].self, from: data)
                completion(characters, nil)
              }
              catch {
                print("response decoding error: \(error.localizedDescription)")
                completion(nil, .invalidData)
              }
            }
        }.resume()
    }
}
