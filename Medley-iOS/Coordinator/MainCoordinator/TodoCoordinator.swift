//
//  TodoCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol TodoCoordinatable: Coordinator {
    var parentCoordinator: MainCoordinatable? { get set }
}

class TodoCoordinator: TodoCoordinatable {

    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinatable?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TodoViewController.instantiate(from: "Main")
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
}
