//
//  SignupSuccessViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/23/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class SignupSuccessViewController: UIViewController, SignupSuccessView {
    var viewModel: SignupSuccessViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewModel.navigateToLogin()
    }
}
