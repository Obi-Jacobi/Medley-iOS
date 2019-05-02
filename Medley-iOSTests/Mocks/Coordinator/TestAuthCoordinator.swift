//
//  TestAuthCoordinator.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 4/30/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
@testable import Medley_iOS

class TestAuthCoordinator: AuthCoordinatable {
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinatable?

    init() {
        self.navigationController = UINavigationController()
    }

    var startCalled = false
    func start() {
        startCalled = true
    }

    var loginCalled = false
    func login() {
        loginCalled = true
    }

    var signupCalled = false
    func signup() {
        signupCalled = true
    }

    var successfulSignupCalled = false
    func successfulSignup() {
        successfulSignupCalled = true
    }

    var successfulLoginCalled = false
    func successfulLogin() {
        successfulLoginCalled = true
    }
}
