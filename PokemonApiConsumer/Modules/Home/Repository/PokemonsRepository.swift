//
//  PokemonsRepository.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import UIKit

enum Errors: Error {
    case requestError
    case error
    case decodeError
}

class PokemonsRepository {
    var urlSession: UrlSessionDataProvider
    
    init(urlSession: UrlSessionDataProvider = .init()) {
        self.urlSession = urlSession
    }
    
    private func createRequest(pokemonsQuantity: Int, page: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards?page=\(page)&pageSize=\(pokemonsQuantity)&select=id,name") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-API-Key": "03f39224-ce95-47d5-afff-a4f1b765bd39",
            "Accept-Type": "application/json"
        ]
                
        return request
    }
    
    public func getPokemons( totalPokemonsPerPage: Int, page: Int, completion: @escaping (Result<PokemonDataModel?, Errors>) -> Void ) {
        guard let request = createRequest(pokemonsQuantity: totalPokemonsPerPage, page: page) else { return }
        
        self.urlSession.executeRequest(request: request) { data, response, error in
            let response = response as? HTTPURLResponse ?? HTTPURLResponse()
            let data = data ?? Data()
            let isThereError = error != nil
            let isNotResponseA200 = response.statusCode != 200
            
            if isThereError {
                completion(.failure(.error))
                return
            }
            
            if isNotResponseA200 {
                completion(.failure(.requestError))
                return
            }
            
            guard let decodedData: PokemonDataModel = try? JSONDecoder().decode(PokemonDataModel.self, from: data) else { completion(.failure(.decodeError)); return }

            completion(.success(decodedData))
        }
    }
    
    private func createCardRequest (id: String) -> URLRequest? {
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards/\(id)?select=images") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-API-Key": "03f39224-ce95-47d5-afff-a4f1b765bd39",
            "Accept-Type": "application/json"
        ]
                
        return request
    }
    
    public func getCard( cardId: String, completion: @escaping (Result<PokemonCardModel?, Errors>) -> Void ) {
        guard let request = createCardRequest(id: cardId) else { return }
        
        self.urlSession.executeRequest(request: request) { data, response, error in
            let response = response as? HTTPURLResponse ?? HTTPURLResponse()
            let data = data ?? Data()
            let isThereError = error != nil
            let isNotResponseA200 = response.statusCode != 200
            
            if isThereError {
                completion(.failure(.error))
                return
            }
            
            if isNotResponseA200 {
                completion(.failure(.requestError))
                return
            }

            guard let decodedCard: PokemonCardModel = try? JSONDecoder().decode(PokemonCardModel.self, from: data) else { completion(.failure(.decodeError)); return }
            completion(.success(decodedCard))
        }
    }
}
