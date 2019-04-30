//
//  SignupViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SignupVM {
    // Inputs
    func nameChanged(_ newName: String)
    func emailChanged(_ newEmail: String)
    func passwordChanged(_ newPassword: String)
    func verifyPasswordChanged(_ newVerifyPassword: String)
    func signup()
    func navigateToLogin()

    // Outputs
    var isLoading: Driver<Bool> { get }
    var signupEnabled: Driver<Bool> { get }
}

class SignupViewModel: SignupVM {

    let signupEnabled: Driver<Bool>
    let isLoading: Driver<Bool>

    private let apiService: ApiService
    private weak var coordinator: AuthCoordinatable?

    init(apiService: ApiService,
         coordinator: AuthCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator

        self.signupEnabled = Observable.combineLatest(name, email, password, verifyPassword) { nameValue, emailValue, passwordValue, verifyPasswordValue in
            return !nameValue.isEmpty && !emailValue.isEmpty && !passwordValue.isEmpty && !verifyPasswordValue.isEmpty
        }.asDriver(onErrorJustReturn: false)

        self.isLoading = signupLoading.asDriver(onErrorJustReturn: false)
    }

    private let name = BehaviorRelay(value: "")
    func nameChanged(_ newName: String) { name.accept(newName) }

    private let email = BehaviorRelay(value: "")
    func emailChanged(_ newEmail: String) { email.accept(newEmail) }

    private let password = BehaviorRelay(value: "")
    func passwordChanged(_ newPassword: String) { password.accept(newPassword) }

    private let verifyPassword = BehaviorRelay(value: "")
    func verifyPasswordChanged(_ newVerifyPassword: String) { verifyPassword.accept(newVerifyPassword) }

    private let signupLoading = BehaviorRelay(value: false)
    func signup() {
        let signupRequest = SignupRequest(name: name.value, email: email.value, password: password.value, verifyPassword: verifyPassword.value)

        signupLoading.accept(true)
        try? apiService.signup(request: signupRequest) { result in
            switch result {
            case .success:
                self.coordinator?.successfulSignup()
            case .failure(let error):
                print("Error perform signup request \(error)")
            }
            self.signupLoading.accept(false)
        }
    }

    func navigateToLogin() {
        self.coordinator?.login()
    }
}
