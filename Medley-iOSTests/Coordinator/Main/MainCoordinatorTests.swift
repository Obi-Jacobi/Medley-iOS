//
//  MainCoordinatorTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
@testable import Medley_iOS

class MainCoordinatorTests: XCTestCase {

    var testNavigationController: UINavigationController!
    var testAuthService: TestAuthService!
    var testAuthCoordinator: TestAuthCoordinator!
    var testTodoCoordinator: TestTodoCoordinator!

    var coordinator: MainCoordinator!

    override func setUp() {
        super.setUp()

        testNavigationController = UINavigationController()
        testAuthService = TestAuthService()
        testAuthCoordinator = TestAuthCoordinator()
        testTodoCoordinator = TestTodoCoordinator()

        coordinator = MainCoordinator(navigationController: testNavigationController, authService: testAuthService, authCoordinator: testAuthCoordinator, todoCoordinator: testTodoCoordinator)
    }

    override func tearDown() {
        super.tearDown()

        coordinator = nil
    }

    func testThat_it_starts_login_with_no_authToken() {
        XCTAssertFalse(testAuthCoordinator.startCalled)
        XCTAssertFalse(testTodoCoordinator.startCalled)

        coordinator.start()

        XCTAssertTrue(testAuthCoordinator.startCalled)
        XCTAssertFalse(testTodoCoordinator.startCalled)
    }

    func testThat_it_starts_todo_with_authToken() {
        XCTAssertFalse(testAuthCoordinator.startCalled)
        XCTAssertFalse(testTodoCoordinator.startCalled)

        testAuthService.authToken = "authToken"

        coordinator.start()

        XCTAssertFalse(testAuthCoordinator.startCalled)
        XCTAssertTrue(testTodoCoordinator.startCalled)
    }
}
