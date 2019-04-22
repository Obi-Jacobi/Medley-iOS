//
//  LoginViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift

class LoginViewModel {

    let email: Observable<String>
    private let emailSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    let password: Observable<String>
    private let passwordSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    private let apiService: ApiService
    private let goToSignup: () -> Void

    private let disposeBag = DisposeBag()

    init(apiService: ApiService,
         goToSignup: @escaping () -> Void) {

        self.apiService = apiService
        self.goToSignup = goToSignup

        self.email = emailSubject.asObservable()
        self.password = passwordSubject.asObservable()
    }

    func update(email: String,
                password: String) {

        emailSubject.onNext(email)
        passwordSubject.onNext(password)
    }

    func login() {
        let emailValue = (try? emailSubject.value()) ?? ""
        let passwordValue = (try? passwordSubject.value()) ?? ""

        let loginRequest = LoginRequest(email: emailValue, password: passwordValue)

        try? apiService.login(request: loginRequest) { result in
            switch result {
            case .success(let response):
                print(response.body)
            case .failure(let error):
                print("Error performing login request \(error)")
            }
        }
    }

    func navigateToSignup() {
        goToSignup()
    }
}
