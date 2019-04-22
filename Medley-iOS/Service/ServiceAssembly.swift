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
            return ApiClient()
        }.inObjectScope(.transient)

    }
}
