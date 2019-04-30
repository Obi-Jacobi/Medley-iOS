//
//  MainCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol MainCoordinatable: Coordinator {
    var authCoordinator: AuthCoordinatable { get }
    var todoCoordinator: TodoCoordinatable { get }

    func succesfulLogin()
}

class MainCoordinator: MainCoordinatable {

    var navigationController: UINavigationController
    var authCoordinator: AuthCoordinatable
    var todoCoordinator: TodoCoordinatable

    init(navigationController: UINavigationController,
         authCoordinator: AuthCoordinatable,
         todoCoordinator: TodoCoordinatable) {

        self.navigationController = navigationController
        self.authCoordinator = authCoordinator
        self.todoCoordinator = todoCoordinator

        self.authCoordinator.parentCoordinator = self
        self.todoCoordinator.parentCoordinator = self
    }

    func start() {
        let defaults = UserDefaults.standard
        let authToken = defaults.string(forKey: "authToken")

        guard authToken != nil else {
            authCoordinator.start()
            return
        }

        succesfulLogin()
    }

    func succesfulLogin() {
        todoCoordinator.start()
    }
}
