//
//  MainCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol MainCoordinatable: Coordinator {
    var authService: AuthService { get }

    var authCoordinator: AuthCoordinatable { get }
    var todoCoordinator: TodoCoordinatable { get }

    func succesfulLogin()
}

class MainCoordinator: MainCoordinatable {

    var navigationController: UINavigationController
    var authService: AuthService
    var authCoordinator: AuthCoordinatable
    var todoCoordinator: TodoCoordinatable

    init(navigationController: UINavigationController,
         authService: AuthService,
         authCoordinator: AuthCoordinatable,
         todoCoordinator: TodoCoordinatable) {

        self.navigationController = navigationController
        self.authService = authService

        self.authCoordinator = authCoordinator
        self.todoCoordinator = todoCoordinator

        self.authCoordinator.parentCoordinator = self
        self.todoCoordinator.parentCoordinator = self
    }

    func start() {
        guard authService.authToken != nil else {
            authCoordinator.start()
            return
        }

        succesfulLogin()
    }

    func succesfulLogin() {
        todoCoordinator.start()
    }
}
