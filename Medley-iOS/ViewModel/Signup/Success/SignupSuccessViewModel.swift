//
//  SignupSuccessViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/23/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

protocol SignupSuccessVM {
    func navigateToLogin()
}

class SignupSuccessViewModel: SignupSuccessVM {

    private weak var coordinator: AuthCoordinatable?

    init(coordinator: AuthCoordinatable) {
        self.coordinator = coordinator
    }

    func navigateToLogin() {
        coordinator?.login()
    }
}
