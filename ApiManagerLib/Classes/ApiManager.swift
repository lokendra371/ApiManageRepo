//
//  ApiManage.swift
//  YouTubeMvvmProduct
//
//  Created by SBIEPAY on 13/06/25.
// Some changes lokendra

import Foundation

public class APIClient {
    public static let shared = APIClient()
    private init() {}

    public func get<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
