//
//  LoginViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift
import RxCocoa

protocol LoginVM {
    // Inputs
    func emailChanged(_ newEmail: String)
    func passwordChanged(_ newPassword: String)
    func login()
    func navigateToSignup()

    // Outputs
    var isLoading: Driver<Bool> { get }
    var loginEnabled: Driver<Bool> { get }
}

class LoginViewModel: LoginVM {

    let isLoading: Driver<Bool>
    let loginEnabled: Driver<Bool>

    private let apiService: ApiService
    private var authService: AuthService
    private weak var coordinator: AuthCoordinatable?

    init(apiService: ApiService,
         authService: AuthService,
         coordinator: AuthCoordinatable) {

        self.apiService = apiService
        self.authService = authService
        self.coordinator = coordinator

        self.loginEnabled = Observable.combineLatest(email, password) { emailValue, passwordValue in
            return !emailValue.isEmpty && !passwordValue.isEmpty
        }.asDriver(onErrorJustReturn: false)

        self.isLoading = loginLoading.asDriver(onErrorJustReturn: false)
    }

    private let email = BehaviorRelay(value: "")
    func emailChanged(_ newEmail: String) { email.accept(newEmail) }

    private let password = BehaviorRelay(value: "")
    func passwordChanged(_ newPassword: String) { password.accept(newPassword) }

    private let loginLoading = BehaviorRelay(value: false)
    func login() {
        let loginRequest = LoginRequest(email: email.value, password: password.value)

        loginLoading.accept(true)
        try? apiService.login(request: loginRequest) { result in
            switch result {
            case .success(let response):
                self.authService.authToken = response.string

                self.coordinator?.successfulLogin()
            case .failure(let error):
                print("Error performing login request \(error)")
            }
            self.loginLoading.accept(false)
        }
    }

    func navigateToSignup() {
        coordinator?.signup()
    }
}
