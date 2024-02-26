//
//  PokemonsLoaderIndicatorView.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/02/24.
//

import UIKit

class PokemonsLoaderIndicatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public let loadingIndicator: UIActivityIndicatorView = {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.duration = 2.0
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2.0
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = .forwards

        let loader = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loader.hidesWhenStopped = true
        loader.style = UIActivityIndicatorView.Style.medium
        loader.layer.add(rotationAnimation, forKey: "rotation")
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        return loader
    }()
    
    private func setConfiguration() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
