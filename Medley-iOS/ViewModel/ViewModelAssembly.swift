//
//  Assembly.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignupVM.self) { r in
            let apiService = r.resolve(ApiService.self)!
            let coordinator = r.resolve(AuthCoordinatable.self, argument: UINavigationController())!

            return SignupViewModel(apiService: apiService, coordinator: coordinator)
        }.inObjectScope(.transient)

        container.register(SignupSuccessVM.self) { r in
            let coordinator = r.resolve(AuthCoordinatable.self, argument: UINavigationController())!

            return SignupSuccessViewModel(coordinator: coordinator)
        }.inObjectScope(.transient)

        container.register(LoginVM.self) { r in
            let apiService = r.resolve(ApiService.self)!
            let coordinator = r.resolve(AuthCoordinatable.self, argument: UINavigationController())!

            return LoginViewModel(apiService: apiService, coordinator: coordinator)
        }.inObjectScope(.transient)

        container.register(TodoVM.self) { r in
            let apiService = r.resolve(ApiService.self)!
            let coordinator = r.resolve(TodoCoordinatable.self, argument: UINavigationController())!

            return TodoViewModel(apiService: apiService, coordinator: coordinator)
        }.inObjectScope(.transient)
    }
}
