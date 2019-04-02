//
//  Result.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

public enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}
