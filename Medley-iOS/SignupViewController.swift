//
//  SignupViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, Storyboarded, CoordinatedView {

    var coordinator: SignupCoordinatable!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        coordinator.login()
    }
}
