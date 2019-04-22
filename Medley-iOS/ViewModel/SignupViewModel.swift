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

    private let coordinator: SignupCoordinatable
    private let apiService: ApiService

    private let disposeBag = DisposeBag()

    init(coordinator: SignupCoordinatable,
         apiService: ApiService) {
        self.coordinator = coordinator
        self.apiService = apiService

        self.name = nameSubject.asObservable()

        name.subscribe(onNext: {
            print("New Name Value: \($0)")
        })
        .disposed(by: disposeBag)
    }

    func update(name: String) {
        nameSubject.onNext(name)
    }

    func signup() {
        let nameValue = (try? nameSubject.value()) ?? ""
        let signupRequest = SignupRequest(name: nameValue, email: "jwilson9553@gmail.com", password: "password", verifyPassword: "password")

        try? apiService.signup(request: signupRequest) { result in
            switch result {
            case .success(let response):
                print(response.body)
            case .failure(let error):
                print("Error perform signup request \(error)")
            }
        }
    }

    func goBackToLogin() {
        coordinator.login()
    }
}
