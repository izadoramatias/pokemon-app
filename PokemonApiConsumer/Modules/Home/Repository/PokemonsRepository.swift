//
//  PokemonsRepository.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import UIKit

class PokemonsRepository {
    private var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func createRequest(pokemonsQuantity: Int, page: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards?page=\(page)&pageSize=\(pokemonsQuantity)&select=id,name,images") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-API-Key": "03f39224-ce95-47d5-afff-a4f1b765bd39",
            "Accept-Type": "application/json"
        ]
        
        return request
    }
    
    public func getPokemons( completion: @escaping (PokemonDataModel?) -> Void, totalPokemonsPerPage: Int, page: Int ) {
        guard let request = createRequest(pokemonsQuantity: totalPokemonsPerPage, page: page) else { return }
        
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Request error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if (response.statusCode != 200) {
                print("Um erro ocorreu ao processar o pedido")
                return
            }
            
            guard let data = data else { return }
            
            guard let decodedJsonData: PokemonDataModel? = try? JSONDecoder().decode(PokemonDataModel.self, from: data) else { return }
            
            completion(decodedJsonData)
        }
        task.resume()
    }
}
