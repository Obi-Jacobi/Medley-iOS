//
//  TodoViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, TodoView {

    var viewModel: TodoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        viewModel.getTodos()
    }

    @IBAction func getTodos(_ sender: UIButton) {
        viewModel.getTodos()
    }

    @IBAction func makeTodo(_ sender: UIButton) {
        viewModel.makeTodo()
    }
}
