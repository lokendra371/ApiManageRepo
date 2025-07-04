//
//  ApiManage.swift
//  YouTubeMvvmProduct
//
//  Created by SBIEPAY on 13/06/25.
//

import Foundation

enum DataError:Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError (Error)
}

//typealias   handler = (Result<[Product], DataError>) -> Void
typealias   handler <T> = (Result<T, DataError>) -> Void

//Singlton Design pattern
final public class APIManager {
    
    static let  shared = APIManager()
    private  init()
    {
        
    }
    
    func requestFetch<T:Codable>(modelType:T.Type ,type:EndPointType,compition:@escaping handler<T>)
    {
        guard let url = type.url else {
            compition(.failure(.invalidURL))
            
            return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        request.allHTTPHeaderFields = type.httpHeaders
        
        if let parameter = type.body {
            
            let jsonData = try? JSONEncoder().encode(parameter)
            request.httpBody = jsonData
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            guard let data ,error == nil else {
                compition(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse , 200 ... 299 ~= response.statusCode  else {
                compition(.failure(.invalidResponse))
                return }
            //json decode convert data into model
            do {
                let product = try JSONDecoder().decode(modelType, from: data)
                print(product)
                compition(.success(product))
            } catch {
                print("JSON parsing error: \(error)")
                compition(.failure(.networkError(error)))
            }
        }.resume()
    }
    
    
    static var commaonHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    
    
}

// singlton class ka object  create hoga outside the class to small singlton class hota he
// Singlton class ka object  create nahi hoga outside the class to big singlton class hota he
// final class that means inheritence restriction
