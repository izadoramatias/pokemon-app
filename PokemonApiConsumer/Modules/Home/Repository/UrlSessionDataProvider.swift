//
//  UrlSessionProtocol.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 28/02/24.
//

import Foundation

class UrlSessionDataProvider {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void){
        self.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
