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
}

class MainCoordinator: MainCoordinatable {

    var navigationController: UINavigationController
    var authCoordinator: AuthCoordinatable

    init(navigationController: UINavigationController,
         authCoordinator: AuthCoordinatable) {

        self.navigationController = navigationController
        self.authCoordinator = authCoordinator
    }

    func start() {
        authCoordinator.start()
    }
}
