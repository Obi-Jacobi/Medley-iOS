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
            let todoCoordinator = r.resolve(TodoCoordinatable.self, argument: navigationController)!

            return MainCoordinator(navigationController: navigationController, authCoordinator: authCoordinator, todoCoordinator: todoCoordinator)
        }.inObjectScope(.container)

        container.register(AuthCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            return AuthCoordinator(resolver: r, navigationController: navigationController)
        }.inObjectScope(.container)

        container.register(TodoCoordinatable.self) { (r: Resolver, navigationController: UINavigationController) in
            return TodoCoordinator(resolver: r, navigationController: navigationController)
        }.inObjectScope(.container)
    }
}
