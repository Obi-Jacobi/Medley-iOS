//
//  LoginCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol AuthCoordinatable: Coordinator {
    var parentCoordinator: MainCoordinatable? { get set }

    func login()
    func signup()
    func successfulSignup()
    func successfulLogin()
}

class AuthCoordinator: AuthCoordinatable {

    typealias LoginViewFactory = () -> LoginView
    typealias SignupViewFactory = () -> SignupView
    typealias SignupSuccessViewFactory = () -> SignupSuccessView

    var navigationController: UINavigationController
    var loginView: LoginViewFactory
    var signupView: SignupViewFactory
    var signupSuccessView: SignupSuccessViewFactory
    weak var parentCoordinator: MainCoordinatable?

    init(navigationController: UINavigationController,
         loginView: @escaping LoginViewFactory,
         signupView: @escaping SignupViewFactory,
         signupSuccessView: @escaping SignupSuccessViewFactory) {

        self.navigationController = navigationController
        self.loginView = loginView
        self.signupView = signupView
        self.signupSuccessView = signupSuccessView
    }

    func start() {
        navigationController.isNavigationBarHidden = true

        login()
    }

    func login() {
        let view = loginView()

        navigationController.setViewControllers([view], animated: true)
    }

    func signup() {
        let view = signupView()

        navigationController.setViewControllers([view], animated: true)
    }

    func successfulSignup() {
        let view = signupSuccessView()

        navigationController.setViewControllers([view], animated: true)
    }

    func successfulLogin() {
        parentCoordinator?.succesfulLogin()
    }
}
