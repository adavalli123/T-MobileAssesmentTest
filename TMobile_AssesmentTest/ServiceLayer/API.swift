//
//  API.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/30/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct API {
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
    static let baseUrl = "https://api.github.com/users"
    
    static func request(with endPoint: String, completion: @escaping NetworkCompletion) {
        var endPoint = endPoint
        if endPoint.isEmpty == false {
            endPoint.insert("/", at: endPoint.startIndex)
        }
        
        guard let url = URL(string: baseUrl + endPoint) else { return }
        let session = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url)
        
        // We are having restrictions on number of calls. If you own a token then the restriction will be lesser
        urlRequest.addValue("token 8c071e6b32799f5fe524d034d5110bb0b7147b12", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        
        dataTask.resume()
    }
}
