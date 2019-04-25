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

    func login()
    func signup()
    func successfulSignup()
    func successfulLogin()
}

class AuthCoordinator: AuthCoordinatable {

    var resolver: Resolver
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinatable?

    init(resolver: Resolver,
         navigationController: UINavigationController) {

        self.resolver = resolver
        self.navigationController = navigationController
    }

    func start() {
        navigationController.isNavigationBarHidden = true

        login()
    }

    func login() {
        let view = resolver.resolve(LoginView.self)!

        navigationController.setViewControllers([view], animated: true)
    }

    func signup() {
        let view = resolver.resolve(SignupView.self)!

        navigationController.setViewControllers([view], animated: true)
    }

    func successfulSignup() {
        let view = resolver.resolve(SignupSuccessView.self)!

        navigationController.setViewControllers([view], animated: true)
    }

    func successfulLogin() {
        parentCoordinator?.succesfulLogin()
    }
}
