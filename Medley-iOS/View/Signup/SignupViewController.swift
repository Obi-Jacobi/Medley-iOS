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
    
    var viewModel: SignupViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    private func setupBindings() {
        viewModel.name
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.email
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.password
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.verifyPassword
            .bind(to: verifyPasswordTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewModel.navigateToLogin()
    }

    @IBAction func signupButton(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let verifyPassword = verifyPasswordTextField.text ?? ""

        viewModel.update(name: name, email: email, password: password, verifyPassword: verifyPassword)

        viewModel.signup()
    }
}
