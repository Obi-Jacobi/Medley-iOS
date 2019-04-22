//
//  LoginCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import Swinject

protocol AuthCoordinatable: Coordinator {
    var parentCoordinator: MainCoordinatable? { get set }

    var loginCoordinator: LoginCoordinatable { get }
    var signupCoordinator: SignupCoordinatable { get }

    func login()
    func signup()
}

class AuthCoordinator: AuthCoordinatable {

    let loginCoordinator: LoginCoordinatable
    let signupCoordinator: SignupCoordinatable

    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinatable?

    init(navigationController: UINavigationController,
         signupCoordinator: SignupCoordinatable,
         loginCoordinator: LoginCoordinatable) {

        self.navigationController = navigationController
        self.signupCoordinator = signupCoordinator
        self.loginCoordinator = loginCoordinator

        loginCoordinator.parentCoordinator = self
        signupCoordinator.parentCoordinator = self
    }

    func start() {
        loginCoordinator.start()
    }

    func login() {
        loginCoordinator.start()
    }

    func signup() {
        signupCoordinator.start()
    }
}

protocol SignupCoordinatable: Coordinator {
    var parentCoordinator: AuthCoordinatable? { get set }

    func login()
}

class SignupCoordinator: SignupCoordinatable {

    var navigationController: UINavigationController
    var resolver: Resolver

    weak var parentCoordinator: AuthCoordinatable?

    init(navigationController: UINavigationController,
         resolver: Resolver) {

        self.navigationController = navigationController
        self.resolver = resolver
    }

    func start() {
        let viewModel = resolver.resolve(SignupViewModel.self, argument: { () -> Void in
            self.login()
        })!

        let view = resolver.resolve(SignupView.self, argument: viewModel)!

        navigationController.setViewControllers([view], animated: false)
    }

    func login() {
        parentCoordinator?.login()
    }
}

protocol LoginCoordinatable: Coordinator {
    var parentCoordinator: AuthCoordinatable? { get set }

    func signup()
}

class LoginCoordinator: LoginCoordinatable {

    var navigationController: UINavigationController
    var resolver: Resolver

    weak var parentCoordinator: AuthCoordinatable?

    init(navigationController: UINavigationController,
         resolver: Resolver) {

        self.navigationController = navigationController
        self.resolver = resolver
    }

    func start() {
        let viewModel = resolver.resolve(LoginViewModel.self, argument: { () -> Void in
            self.signup()
        })!

        let view = resolver.resolve(LoginView.self, argument: viewModel)!

        navigationController.setViewControllers([view], animated: false)
    }

    func signup() {
        parentCoordinator?.signup()
    }
}
