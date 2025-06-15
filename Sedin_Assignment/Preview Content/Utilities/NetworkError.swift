//
//  NetworkError.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import Foundation


enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noIneInternet
    case requestFailed(Error)
    case statusCode(Int)
    case decodingFailed(Error)
    case timeOut(Error)
    case unKnown
    
    var errorDescription: String{
        switch self{
        case .invalidURL:
            return "Invalid URL"
        case .noIneInternet:
            return "No Internet Connection"
        case .requestFailed(let error):
            return "Request Failed \(error.localizedDescription)"
        case .statusCode(let statusCode):
            return "Status Code: \(statusCode)"
        case .decodingFailed(let error):
            return "Decoding Error \(error.localizedDescription)"
            
        case .timeOut(let error):
            return "Request Time Out Error \(error.localizedDescription)"
        case .unKnown:
            return "Unknown Error thrown"
        }
    }
}
