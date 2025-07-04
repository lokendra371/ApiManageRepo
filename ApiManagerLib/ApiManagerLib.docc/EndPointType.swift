//
//  EndPointType.swift
//  YouTubeMvvmProduct
//
//  Created by SBIEPAY on 20/06/25.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}


protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var httpMethod: HttpMethod { get }
    var httpHeaders: [String: String]? { get }
    var body: Encodable? { get }
}

