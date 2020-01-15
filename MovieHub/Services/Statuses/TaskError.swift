//
//  TaskError.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

public enum TaskError: Error {
    case notConnectedToInternet
    case errorAPI
    case errorParsing
    case errorDB
    
    
    var errorDescription: String {
        switch self {
        case .notConnectedToInternet: return "Ошибка соединения"
        case .errorAPI: return "Ошибка запроса"
        case .errorParsing: return "Ошибка данных"
        case .errorDB: return "Ошибка сохраненения"
        }
    }
}
