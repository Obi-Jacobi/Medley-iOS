//
//  ViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded {

    var coordinator: LoginCoordinatable!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupButton(_ sender: UIButton) {
        coordinator.signup()
    }
    
}

