//
//  UrlSessionDataProviderMock.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/03/24.
//

import Foundation

class UrlSessionDataProviderMock: UrlSessionDataProvider {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, response, error)
    }
}
