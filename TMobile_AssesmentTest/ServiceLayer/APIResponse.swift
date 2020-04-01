//
//  APIResponse.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct APIResponse {
    static func handle<T: Decodable>(url: String, decodingType: T.Type, completion: @escaping (T?, ErrorType?) -> ()) {
        API.request(with: url) { (data, urlResponse, error) in
            guard
                let data = data,
                let response = urlResponse as? HTTPURLResponse,
                (response.statusCode >= 300 || response.statusCode < 200) == false
                else {
                    completion(nil, ErrorType.invalidResponse)
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let decodableObject = try decoder.decode(decodingType, from: data)
                completion(decodableObject, nil)
            } catch let error {
                completion(nil, ErrorType.apiFailure(failure: error))
            }
        }
    }
}
