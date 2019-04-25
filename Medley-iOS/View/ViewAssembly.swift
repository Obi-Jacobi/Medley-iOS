//
//  ViewAssembly.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Swinject

class ViewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignupView.self) { r in
            let viewModel = r.resolve(SignupViewModel.self)!

            let vc = SignupViewController.instantiate(from: "Main")
            vc.viewModel = viewModel
            return vc
        }.inObjectScope(.transient)

        container.register(SignupSuccessView.self) { r in
            let viewModel = r.resolve(SignupSuccessViewModel.self)!

            let vc = SignupSuccessViewController.instantiate(from: "Main")
            vc.viewModel = viewModel
            return vc
        }.inObjectScope(.transient)

        container.register(LoginView.self) { r in
            let viewModel = r.resolve(LoginViewModel.self)!

            let vc = LoginViewController.instantiate(from: "Main")
            vc.viewModel = viewModel
            return vc
        }.inObjectScope(.transient)

        container.register(TodoView.self) { r in
            let viewModel = r.resolve(TodoViewModel.self)!

            let vc = TodoViewController.instantiate(from: "Main")
            vc.viewModel = viewModel
            return vc
        }.inObjectScope(.transient)
        
    }
}
