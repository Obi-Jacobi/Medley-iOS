//
//  MainCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol MainCoordinatable: Coordinator {
    var authCoordinator: AuthCoordinator { get }
}

class MainCoordinator: MainCoordinatable {

    var navigationController: UINavigationController
    var authCoordinator: AuthCoordinator

    init() {
        navigationController = UINavigationController()

        authCoordinator = AuthCoordinator(navigationController: navigationController)
    }

    func start() {
        authCoordinator.start()
    }
}
