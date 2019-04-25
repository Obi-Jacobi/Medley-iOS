//
//  TodoCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import Swinject

protocol TodoCoordinatable: Coordinator {
    var parentCoordinator: MainCoordinatable? { get set }
}

class TodoCoordinator: TodoCoordinatable {

    var resolver: Resolver
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinatable?

    init(resolver: Resolver,
         navigationController: UINavigationController) {

        self.resolver = resolver
        self.navigationController = navigationController
    }

    func start() {
        let view = resolver.resolve(TodoView.self)!

        navigationController.setViewControllers([view], animated: true)
    }
}
