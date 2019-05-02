//
//  SignupSuccessViewModelTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
@testable import Medley_iOS

class SignupSuccessViewModelTests: XCTestCase {

    var testAuthCoordinator: TestAuthCoordinator!

    var viewModel: SignupSuccessViewModel!

    override func setUp() {
        super.setUp()

        testAuthCoordinator = TestAuthCoordinator()

        viewModel = SignupSuccessViewModel(coordinator: testAuthCoordinator)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
    }

    func testThat_it_navigates_toLogin() {
        XCTAssertFalse(testAuthCoordinator.loginCalled)

        viewModel.navigateToLogin()

        XCTAssertTrue(testAuthCoordinator.loginCalled)
    }
}
