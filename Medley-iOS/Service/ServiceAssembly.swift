//
//  ServiceAssembly.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ApiService.self) { r in
            let authService = r.resolve(AuthService.self)!

            return ApiClient(authService: authService)
        }.inObjectScope(.transient)

        container.register(AuthService.self) { r in
            return AuthClient()
        }.inObjectScope(.transient)
    }
}
