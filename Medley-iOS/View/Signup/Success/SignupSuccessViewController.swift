//
//  SignupSuccessViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/23/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignupSuccessViewController: UIViewController, SignupSuccessView {
    @IBOutlet private weak var loginButton: UIButton!
    
    var viewModel: SignupSuccessVM!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.rx.tap.asObservable().subscribe(onNext: viewModel.navigateToLogin).disposed(by: disposeBag)
    }
}
