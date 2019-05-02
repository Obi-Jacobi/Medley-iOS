//
//  Assembly.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Swinject

class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainCoordinatable.self) { r in
            let navigationController = UINavigationController()
            let authService = r.resolve(AuthService.self)!

            let authCoordinator = r.resolve(AuthCoordinatable.self, argument: navigationController)!
            let todoCoordinator = r.resolve(TodoCoordinatable.self, argument: navigationController)!

            return MainCoordinator(navigationController: navigationController, authService: authService, authCoordinator: authCoordinator, todoCoordinator: todoCoordinator)
        }.inObjectScope(.container)

        container.register(AuthCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            let loginView = {
                return r.resolve(LoginView.self)!
            }
            let signupView = {
                return r.resolve(SignupView.self)!
            }
            let signupSuccessView = {
                return r.resolve(SignupSuccessView.self)!
            }

            return AuthCoordinator(navigationController: navigationController, loginView: loginView, signupView: signupView, signupSuccessView: signupSuccessView)
        }.inObjectScope(.container)

        container.register(TodoCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            let todoView = {
                return r.resolve(TodoView.self)!
            }

            return TodoCoordinator(navigationController: navigationController, todoView: todoView)
        }.inObjectScope(.container)
    }
}
