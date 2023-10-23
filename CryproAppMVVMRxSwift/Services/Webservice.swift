//
//  Webservice.swift
//  CryproAppMVVMRxSwift
//
//  Created by Айбек on 20.10.2023.
//

import Foundation

enum CryptoError : Error {
    case ServerError
    case ParsingError
}

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
    //URL
        }
    }
}
