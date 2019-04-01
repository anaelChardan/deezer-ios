//
//  Dynamic.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

class Dynamic<T> {

    //MARK : - Properties -
    var bind: (T) -> () = { _ in }
    
    var value: T {
        didSet {
            bind(value)
        }
    }
    
    //MARK : - Lifecycle -
    init(_ v: T) {
        value = v
    }
    
}
