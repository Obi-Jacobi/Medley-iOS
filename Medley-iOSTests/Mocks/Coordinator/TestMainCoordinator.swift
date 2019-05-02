//
//  TestMainCoordinator.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
@testable import Medley_iOS

class TestMainCoordinator: MainCoordinatable {

    var navigationController: UINavigationController
    var authService: AuthService
    var authCoordinator: AuthCoordinatable
    var todoCoordinator: TodoCoordinatable

    init() {
        self.navigationController = UINavigationController()
        self.authService = TestAuthService()
        self.authCoordinator = TestAuthCoordinator()
        self.todoCoordinator = TestTodoCoordinator()
    }

    var startCalled = false
    func start() {
        startCalled = true
    }

    var successfulLoginCalled = false
    func succesfulLogin() {
        successfulLoginCalled = true
    }
}
