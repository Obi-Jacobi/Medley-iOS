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
    var loginEnabled: Driver<Bool> { get }
}

class LoginViewModel: LoginVM {

    let loginEnabled: Driver<Bool>

    private let apiService: ApiService
    private weak var coordinator: AuthCoordinatable?

    init(apiService: ApiService,
         coordinator: AuthCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator

        self.loginEnabled = Observable.combineLatest(email, password) { emailValue, passwordValue in
            return !emailValue.isEmpty && !passwordValue.isEmpty
        }.asDriver(onErrorJustReturn: false)
    }

    private let email = BehaviorRelay(value: "")
    func emailChanged(_ newEmail: String) { email.accept(newEmail) }

    private let password = BehaviorRelay(value: "")
    func passwordChanged(_ newPassword: String) { password.accept(newPassword) }

    func login() {
        let loginRequest = LoginRequest(email: email.value, password: password.value)

        try? apiService.login(request: loginRequest) { result in
            switch result {
            case .success(let response):
                let defaults = UserDefaults.standard
                defaults.set(response.string, forKey: "authToken")

                DispatchQueue.main.async {
                    self.coordinator?.successfulLogin()
                }
            case .failure(let error):
                print("Error performing login request \(error)")
            }
        }
    }

    func navigateToSignup() {
        coordinator?.signup()
    }
}
