//
//  SignupViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: UIViewController, SignupView {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var verifyPasswordTextField: UITextField!
    @IBOutlet private weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: SignupVM!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    private func setupBindings() {
        nameTextField.rx.text.orEmpty.subscribe(onNext: viewModel.nameChanged).disposed(by: disposeBag)
        emailTextField.rx.text.orEmpty.subscribe(onNext: viewModel.emailChanged).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.subscribe(onNext: viewModel.passwordChanged).disposed(by: disposeBag)
        verifyPasswordTextField.rx.text.orEmpty.subscribe(onNext: viewModel.verifyPasswordChanged).disposed(by: disposeBag)

        signupButton.rx.tap.asObservable().subscribe(onNext: viewModel.signup).disposed(by: disposeBag)
        loginButton.rx.tap.asObservable().subscribe(onNext: viewModel.navigateToLogin).disposed(by: disposeBag)

        viewModel.signupEnabled.bind(to: signupButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
