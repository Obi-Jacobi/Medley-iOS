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

    typealias TodoViewFactory = () -> TodoView

    var navigationController: UINavigationController
    var todoView: TodoViewFactory
    weak var parentCoordinator: MainCoordinatable?

    init(navigationController: UINavigationController,
         todoView: @escaping TodoViewFactory) {

        self.navigationController = navigationController
        self.todoView = todoView
    }

    func start() {
        navigationController.isNavigationBarHidden = false

        let view = todoView()

        navigationController.setViewControllers([view], animated: true)
    }
}
