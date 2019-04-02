//
//  Dynamic.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        guard let value = value else { return }
        
        listener?(value)
    }
    
    var value: T? {
        didSet {
            guard let value = value else { return }
            listener?(value)
        }
    }
    
    init(_ v: T?) {
        value = v
    }
}
