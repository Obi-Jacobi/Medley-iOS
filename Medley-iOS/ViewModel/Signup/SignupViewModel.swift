//
//  SignupViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift

class SignupViewModel {
    let name: Observable<String>
    private let nameSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    let email: Observable<String>
    private let emailSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    let password: Observable<String>
    private let passwordSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    let verifyPassword: Observable<String>
    private let verifyPasswordSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")

    private let apiService: ApiService
    private weak var coordinator: AuthCoordinatable?

    private let disposeBag = DisposeBag()

    init(apiService: ApiService,
         coordinator: AuthCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator

        self.name = nameSubject.asObservable()
        self.email = emailSubject.asObservable()
        self.password = passwordSubject.asObservable()
        self.verifyPassword = verifyPasswordSubject.asObservable()

        name.subscribe(onNext: {
            print("New Name Value: \($0)")
        })
        .disposed(by: disposeBag)
    }

    func update(name: String,
                email: String,
                password: String,
                verifyPassword: String) {

        nameSubject.onNext(name)
        emailSubject.onNext(email)
        passwordSubject.onNext(password)
        verifyPasswordSubject.onNext(verifyPassword)
    }

    func signup() {
        let nameValue = (try? nameSubject.value()) ?? ""
        let emailValue = (try? emailSubject.value()) ?? ""
        let passwordValue = (try? passwordSubject.value()) ?? ""
        let verifyPasswordValue = (try? verifyPasswordSubject.value()) ?? ""

        let signupRequest = SignupRequest(name: nameValue, email: emailValue, password: passwordValue, verifyPassword: verifyPasswordValue)

        try? apiService.signup(request: signupRequest) { result in
            switch result {
            case .success(let response):
                print(response.body)
            case .failure(let error):
                print("Error perform signup request \(error)")
            }
        }
    }

    func navigateToLogin() {
        coordinator?.login()
    }
}
