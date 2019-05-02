//
//  TestTodoCoordinator.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
@testable import Medley_iOS

class TestTodoCoordinator: TodoCoordinatable {
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinatable?

    init() {
        self.navigationController = UINavigationController()
    }

    var startCalled = false
    func start() {
        startCalled = true
    }
}
