//
//  AppSettings.swift
//  MovieHub
//
//  Created by Leialey on 20.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

public final class AppSettings {
    public static let shared = AppSettings()
    private var settings: [String: Any]
    
    private init() {
        guard let path = Bundle.main.path(forResource: "apiKeys", ofType: "plist"),
            let settings = NSDictionary(contentsOfFile: path) as? [String : Any] else { fatalError("plist in wrong format") }
        self.settings = settings
    }
    
    public func string(key: String) -> String {
        guard let setting = settings[key] as? String, setting != "" else { fatalError("Value not found or in a wrong format") }
        return setting
    }
}

