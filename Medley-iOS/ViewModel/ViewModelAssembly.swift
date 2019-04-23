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
        container.register(SignupViewModel.self) { r in
            let apiService = r.resolve(ApiService.self)!
            let coordinator = r.resolve(AuthCoordinatable.self, argument: UINavigationController())!

            return SignupViewModel(apiService: apiService, coordinator: coordinator)
        }.inObjectScope(.transient)

        container.register(LoginViewModel.self) { r in
            let apiService = r.resolve(ApiService.self)!
            let coordinator = r.resolve(AuthCoordinatable.self, argument: UINavigationController())!

            return LoginViewModel(apiService: apiService, coordinator: coordinator)
        }.inObjectScope(.transient)
        
    }
}
