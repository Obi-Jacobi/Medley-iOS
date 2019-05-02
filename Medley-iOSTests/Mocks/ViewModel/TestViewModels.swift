//
//  TestViewModels.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Medley_iOS

class TestLoginViewModel: LoginVM {

    init() {
        self.isLoading = loading.asDriver()
        self.loginEnabled = enabled.asDriver()
    }

    var email: String?
    func emailChanged(_ newEmail: String) {
        email = newEmail
    }

    var password: String?
    func passwordChanged(_ newPassword: String) {
        password = newPassword
    }

    var loginCalled = false
    func login() {
        loginCalled = true
    }

    var navigateToSignupCalled = false
    func navigateToSignup() {
        navigateToSignupCalled = true
    }

    var loading = BehaviorRelay(value: false)
    var isLoading: Driver<Bool>

    var enabled = BehaviorRelay(value: false)
    var loginEnabled: Driver<Bool>
}

class TestSignupViewModel: SignupVM {

    init() {
        self.isLoading = loading.asDriver()
        self.signupEnabled = enabled.asDriver()
    }

    var name: String?
    func nameChanged(_ newName: String) {
        name = newName
    }

    var email: String?
    func emailChanged(_ newEmail: String) {
        email = newEmail
    }

    var password: String?
    func passwordChanged(_ newPassword: String) {
        password = newPassword
    }

    var verifyPassword: String?
    func verifyPasswordChanged(_ newVerifyPassword: String) {
        verifyPassword = newVerifyPassword
    }

    var signupCalled = false
    func signup() {
        signupCalled = true
    }

    var navigateToLoginCalled = false
    func navigateToLogin() {
        navigateToLoginCalled = true
    }

    var loading = BehaviorRelay(value: false)
    var isLoading: Driver<Bool>

    var enabled = BehaviorRelay(value: false)
    var signupEnabled: Driver<Bool>
}

class TestSignupSuccessViewModel: SignupSuccessVM {

    var navigateToLoginCalled = false
    func navigateToLogin() {
        navigateToLoginCalled = true
    }
}

class TestTodoViewModel: TodoVM {

    init() {
        self.isLoading = loading.asDriver()
        self.todos = currentTodos.asDriver()
    }

    var getTodosCalled = false
    func getTodos() {
        getTodosCalled = true
    }

    var makeTodoCalled = false
    func makeTodo() {
        makeTodoCalled = true
    }

    var loading = BehaviorRelay(value: false)
    var isLoading: Driver<Bool>

    var currentTodos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])
    var todos: Driver<[Todo]>
}
