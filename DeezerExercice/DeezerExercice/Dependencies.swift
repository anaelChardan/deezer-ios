//
//  Dependencies.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 01/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

typealias FullDependencies = HasRepository

final class Dependencies {
    
    // MARK: - Properties -
    public static var shared = Dependencies()
    
    private(set) var repository: Repository
    
    // MARK: - Lifecycle -
    private init() {
        repository = RemoteRepository()
    }
}

extension Dependencies: HasRepository { }
