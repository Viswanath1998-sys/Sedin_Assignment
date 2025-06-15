//
//  ApiRepository.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager() // to access shared object globally
    
    typealias completionHandler = (Result<[Species], NetworkError>) -> Void
    
    func callSpeciesListAPI(completion: @escaping(completionHandler)) async {
        guard let url = URL(string: "https://aes.shenlu.me/api/v1/species") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? NSError{
                if error.code == NSURLErrorTimedOut{
                    completion(.failure(.timeOut(error)))
                }else if error.code == NSURLErrorNotConnectedToInternet{
                    completion(.failure(.noIneInternet))
                }else {
                    completion(.failure(.requestFailed(error)))
                }
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unKnown))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.statusCode(response.statusCode)))
                return
            }
            
            if let unwrappedData = data{
                do{
                    let decodedResponse = try JSONDecoder().decode([Species].self, from: unwrappedData)
                    completion(.success(decodedResponse))
                    
                }catch let decodingError{
                    completion(.failure(.decodingFailed(decodingError)))
                }
            }else{
                completion(.failure(.unKnown))
            }
        }.resume()
    }
}
