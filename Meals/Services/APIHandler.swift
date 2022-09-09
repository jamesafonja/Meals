//
//  APIHandler.swift
//  Meals
//
//  Created by Revive on 8/30/22.
//

import Foundation

// MARK: - APIHandler
class APIHandler {
    // MARK: Singleton
    static let shared = APIHandler()
    private init() {}
    
    // MARK: GetData function
    func getData(from urlString: String, completion: @escaping (_ data: Data?, _ statusMessage: String) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, "APIHandler: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if
                let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                completion(nil, "APIHandler: Invalid URL response")
            }
            
            if let error = error {
                completion(nil, "APIHandler, Error: \(error)")
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil, "APIHandler: No data")
                print("APIHANDLER: NO DATA")
                return
            }
            
            completion(data, "Data retrieved successfully")
        }
        .resume()
    }
    
}
