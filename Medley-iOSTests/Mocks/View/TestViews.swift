//
//  TestViews.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
@testable import Medley_iOS

class TestLoginView: UIViewController, LoginView {
    var viewModel: LoginVM!

    init(viewModel: LoginVM) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestSignupView: UIViewController, SignupView {
    var viewModel: SignupVM!

    init(viewModel: SignupVM) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestSignupSuccessView: UIViewController, SignupSuccessView {
    var viewModel: SignupSuccessVM!

    init(viewModel: SignupSuccessVM) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestTodoView: UIViewController, TodoView {
    var viewModel: TodoVM!

    init(viewModel: TodoVM) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
