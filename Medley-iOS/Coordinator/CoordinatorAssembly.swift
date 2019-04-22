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
            let authCoordinator = r.resolve(AuthCoordinatable.self, argument: navigationController)!

            return MainCoordinator(navigationController: navigationController, authCoordinator: authCoordinator)
        }.inObjectScope(.container)

        container.register(AuthCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            let signupCoordinator = r.resolve(SignupCoordinatable.self, argument: navigationController)!
            let loginCoordinator = r.resolve(LoginCoordinatable.self, argument: navigationController)!

            return AuthCoordinator(navigationController: navigationController, signupCoordinator: signupCoordinator, loginCoordinator: loginCoordinator)
        }.inObjectScope(.container)

        container.register(SignupCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            return SignupCoordinator(navigationController: navigationController, resolver: r)
        }.inObjectScope(.container)

        container.register(LoginCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            return LoginCoordinator(navigationController: navigationController, resolver: r)
        }.inObjectScope(.container)
    }
}
