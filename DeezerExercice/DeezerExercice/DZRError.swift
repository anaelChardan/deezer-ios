//
//  DZRError.swift
//  DeezerExercice
//
//  Created by Maxime Maheo on 02/04/2019.
//  Copyright © 2019 Deezer. All rights reserved.
//

public enum DZRError: Error {
    case invalidURL
    case error(_ error: Error)
}
