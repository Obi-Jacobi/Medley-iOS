//
//  MainCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController.instantiate(from: "Main")
        navigationController.pushViewController(vc, animated: false)
    }
}
