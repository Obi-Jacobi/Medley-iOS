//
//  ViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, LoginView {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!

    var viewModel: LoginVM!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    private func setupBindings() {
        emailTextField.rx.text.orEmpty.subscribe(onNext: viewModel.emailChanged).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.subscribe(onNext: viewModel.passwordChanged).disposed(by: disposeBag)

        loginButton.rx.tap.asObservable().subscribe(onNext: viewModel.login).disposed(by: disposeBag)
        signupButton.rx.tap.asObservable().subscribe(onNext: viewModel.navigateToSignup).disposed(by: disposeBag)

        viewModel.loginEnabled.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
}

