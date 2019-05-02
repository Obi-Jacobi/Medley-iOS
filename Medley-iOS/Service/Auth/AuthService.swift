//
//  AuthService.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation

protocol AuthService {
    var authToken: String? { get set }
}

class AuthClient: AuthService {
    let defaults = UserDefaults.standard

    var authToken: String? {
        get {
            let authToken = defaults.string(forKey: "authToken")
            return authToken
        }
        set {
            defaults.set(newValue, forKey: "authToken")
        }
    }
}
