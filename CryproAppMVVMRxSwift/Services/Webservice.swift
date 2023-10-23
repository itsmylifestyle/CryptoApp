//
//  Webservice.swift
//  CryproAppMVVMRxSwift
//
//  Created by Айбек on 20.10.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let _ = error {
                completion(Result.failure(CryptoError.serverError))
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                
                if let cryptoList = cryptoList {
                    completion(Result.success(cryptoList))
                } else {
                    completion(Result.failure(CryptoError.parsingError))
                }
            }
        }.resume()
    }
}
