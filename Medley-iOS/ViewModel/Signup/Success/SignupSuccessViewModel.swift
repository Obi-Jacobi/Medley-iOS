//
//  SignupSuccessViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/23/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

class SignupSuccessViewModel {

    private weak var coordinator: AuthCoordinatable?

    init(coordinator: AuthCoordinatable) {

        self.coordinator = coordinator
    }

    func navigateToLogin() {
        coordinator?.login()
    }
}
