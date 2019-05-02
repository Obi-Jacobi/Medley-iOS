//
//  TodoCoordinatorTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
@testable import Medley_iOS

class TodoCoordinatorTests: XCTestCase {

    var testNavigationController: UINavigationController!
    var testTodoView: (() -> TodoView)!

    var testMainCoordinator: TestMainCoordinator!

    var coordinator: TodoCoordinator!

    override func setUp() {
        super.setUp()

        testNavigationController = UINavigationController()
        testTodoView = {
            return TestTodoView(viewModel: TestTodoViewModel())
        }
        testMainCoordinator = TestMainCoordinator()

        coordinator = TodoCoordinator(navigationController: testNavigationController, todoView: testTodoView)
    }

    override func tearDown() {
        super.tearDown()

        coordinator = nil
    }

    func testThat_it_starts_on_todo_view() {
        XCTAssertEqual(testNavigationController.viewControllers, [])

        coordinator.start()

        XCTAssertEqual(testNavigationController.viewControllers.count, 1)
        XCTAssertTrue(testNavigationController.viewControllers[0] is TodoView)
    }
}
