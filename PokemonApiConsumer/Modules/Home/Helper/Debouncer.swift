//
//  Debouncer.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 06/03/24.
//

import Foundation

class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func debounce(completion: @escaping (() -> Void)) -> Void {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { _ in
            completion()
        })
    }
}
