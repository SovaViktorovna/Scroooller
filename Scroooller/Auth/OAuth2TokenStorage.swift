//
//  OAuth2TokenStorage.swift
//  Scroooller
//
//  Created by Виктория Демченко on 04.07.24.
//

import UIKit
class OAuth2TokenStorage{
    static let shared = OAuth2TokenStorage()
    private init() {}
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: Constants.tokenUserDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.tokenUserDefaultsKey)
        }
    }
}
