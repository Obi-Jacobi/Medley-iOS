//
//  AuthCoordinatorTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
@testable import Medley_iOS

class AuthCoordinatorTests: XCTestCase {

    var testNavigationController: UINavigationController!
    var testLoginView: (() -> LoginView)!
    var testSignupView: (() -> SignupView)!
    var testSignupSuccessView: (() -> SignupSuccessView)!
    var testMainCoordinator: TestMainCoordinator!

    var coordinator: AuthCoordinator!

    override func setUp() {
        super.setUp()

        testNavigationController = UINavigationController()

        testLoginView = {
            return TestLoginView(viewModel: TestLoginViewModel())
        }
        testSignupView = {
            return TestSignupView(viewModel: TestSignupViewModel())
        }
        testSignupSuccessView = {
            return TestSignupSuccessView(viewModel: TestSignupSuccessViewModel())
        }
        testMainCoordinator = TestMainCoordinator()

        coordinator = AuthCoordinator(navigationController: testNavigationController, loginView: testLoginView, signupView: testSignupView, signupSuccessView: testSignupSuccessView)
    }

    override func tearDown() {
        super.tearDown()

        coordinator = nil
    }

    func testThat_it_starts_on_login_view() {
        XCTAssertEqual(testNavigationController.viewControllers, [])

        coordinator.start()

        XCTAssertEqual(testNavigationController.viewControllers.count, 1)
        XCTAssertTrue(testNavigationController.viewControllers[0] is LoginView)
    }

    func testThat_login_shows_login_view() {
        XCTAssertEqual(testNavigationController.viewControllers, [])

        coordinator.login()

        XCTAssertEqual(testNavigationController.viewControllers.count, 1)
        XCTAssertTrue(testNavigationController.viewControllers[0] is LoginView)
    }

    func testThat_signup_shows_signup_view() {
        XCTAssertEqual(testNavigationController.viewControllers, [])

        coordinator.signup()

        XCTAssertEqual(testNavigationController.viewControllers.count, 1)
        XCTAssertTrue(testNavigationController.viewControllers[0] is SignupView)
    }

    func testThat_successfulsignup_shows_signupsuccess_view() {
        XCTAssertEqual(testNavigationController.viewControllers, [])

        coordinator.successfulSignup()

        XCTAssertEqual(testNavigationController.viewControllers.count, 1)
    }

    func testThat_successfullogin_calls_parent() {
        coordinator.parentCoordinator = testMainCoordinator
        XCTAssertEqual(testNavigationController.viewControllers, [])
        XCTAssertFalse(testMainCoordinator.successfulLoginCalled)

        coordinator.successfulLogin()

        XCTAssertEqual(testNavigationController.viewControllers, [])
        XCTAssertTrue(testMainCoordinator.successfulLoginCalled)
    }
}
