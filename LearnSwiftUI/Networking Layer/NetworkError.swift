//
//  NetworkError.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

enum NetworkingError: Error, Equatable {
    case invalidResponse(Int)
    case noInternetConnection
    case invalidURL
    case decodingError(String)
    case genericError(String)
    
    func errorMessage() -> String {
        switch self {
        case .invalidResponse(let code):
            return "Server returned invalid response code. Expected between the range 200-299. Server returned \(code)"
        case .noInternetConnection:
            return "Please connect to Internet & try again."
        case .invalidURL:
            return "The URL is invalid, please enter the correct URL and try again"
        case .decodingError(let message):
            return message
        case .genericError(let message):
            return message
        }
    }
}
