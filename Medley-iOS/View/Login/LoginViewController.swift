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

    var viewModel: LoginViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    private func setupBindings() {

        viewModel.email
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.password
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
    }

    @IBAction func loginButton(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        viewModel.update(email: email, password: password)

        viewModel.login()
    }

    @IBAction func signupButton(_ sender: UIButton) {
        viewModel.navigateToSignup()
    }
    
}

