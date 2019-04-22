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

    var viewModel: SignupViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.name
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewModel.navigateToLogin()
    }

    @IBAction func signupButton(_ sender: Any) {
        viewModel.update(name: nameTextField.text ?? "")

        viewModel.signup()
    }
}
