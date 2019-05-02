//
//  TodoViewModelTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 5/2/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Medley_iOS

class TodoViewModelTests: XCTestCase {

    var testApiService: TestApiService!
    var testTodoCoordinator: TestTodoCoordinator!

    var scheduler: TestScheduler!
    var loadingSubscription: Disposable!
    var todosSubscription: Disposable!

    var viewModel: TodoViewModel!

    override func setUp() {
        super.setUp()

        testApiService = TestApiService()
        testTodoCoordinator = TestTodoCoordinator()

        scheduler = TestScheduler(initialClock: 0)

        viewModel = TodoViewModel(apiService: testApiService, coordinator: testTodoCoordinator)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        scheduler = nil
        loadingSubscription?.dispose()
        todosSubscription?.dispose()
        loadingSubscription = nil
        todosSubscription = nil
    }

    func testThat_it_gets_todos_correctly() {
        let expectedTodos = [Todo(id: 1, title: "title", userID: 1)]
        testApiService.allTodos = expectedTodos

        let isLoadingObserver = scheduler.createObserver(Bool.self)
        let todosObserver = scheduler.createObserver([Todo].self)

        scheduler.scheduleAt(0) {
            self.loadingSubscription = self.viewModel.isLoading.asObservable().subscribe(isLoadingObserver)
            self.todosSubscription = self.viewModel.todos.asObservable().subscribe(todosObserver)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.getTodos()
        }

        scheduler.start()

        XCTAssertEqual(isLoadingObserver.events.count, 3)
        let initialLoadingEvent = isLoadingObserver.events[0]
        XCTAssertEqual(initialLoadingEvent.time, 0)
        XCTAssertFalse(initialLoadingEvent.value.element!)

        let isLoadingEvent = isLoadingObserver.events[1]
        XCTAssertEqual(isLoadingEvent.time, 1)
        XCTAssertTrue(isLoadingEvent.value.element!)

        let finishedLoadingEvent = isLoadingObserver.events[2]
        XCTAssertEqual(finishedLoadingEvent.time, 1)
        XCTAssertFalse(finishedLoadingEvent.value.element!)


        XCTAssertEqual(todosObserver.events.count, 2)
        let initialTodosEvent = todosObserver.events[0]
        XCTAssertEqual(initialTodosEvent.time, 0)
        XCTAssertEqual(initialTodosEvent.value.element!, [])

        let loadedTodosEvent = todosObserver.events[1]
        XCTAssertEqual(loadedTodosEvent.time, 1)
        XCTAssertEqual(loadedTodosEvent.value.element!, expectedTodos)
    }

    func testThat_it_does_not_get_todos_because_of_a_bad_response() {
        testApiService.error = .badResult

        let isLoadingObserver = scheduler.createObserver(Bool.self)
        let todosObserver = scheduler.createObserver([Todo].self)

        scheduler.scheduleAt(0) {
            self.loadingSubscription = self.viewModel.isLoading.asObservable().subscribe(isLoadingObserver)
            self.todosSubscription = self.viewModel.todos.asObservable().subscribe(todosObserver)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.getTodos()
        }

        scheduler.start()

        XCTAssertEqual(isLoadingObserver.events.count, 3)
        let initialLoadingEvent = isLoadingObserver.events[0]
        XCTAssertEqual(initialLoadingEvent.time, 0)
        XCTAssertFalse(initialLoadingEvent.value.element!)

        let isLoadingEvent = isLoadingObserver.events[1]
        XCTAssertEqual(isLoadingEvent.time, 1)
        XCTAssertTrue(isLoadingEvent.value.element!)

        let finishedLoadingEvent = isLoadingObserver.events[2]
        XCTAssertEqual(finishedLoadingEvent.time, 1)
        XCTAssertFalse(finishedLoadingEvent.value.element!)


        XCTAssertEqual(todosObserver.events.count, 1)
        let initialTodosEvent = todosObserver.events[0]
        XCTAssertEqual(initialTodosEvent.time, 0)
        XCTAssertEqual(initialTodosEvent.value.element!, [])
    }

    func testThat_it_makes_a_todo_correctly() {
        let expectedTodo = Todo(id: 1, title: "title", userID: 1)
        testApiService.madeTodo = expectedTodo
        testApiService.allTodos = [expectedTodo]

        let isLoadingObserver = scheduler.createObserver(Bool.self)
        let todosObserver = scheduler.createObserver([Todo].self)

        scheduler.scheduleAt(0) {
            self.loadingSubscription = self.viewModel.isLoading.asObservable().subscribe(isLoadingObserver)
            self.todosSubscription = self.viewModel.todos.asObservable().subscribe(todosObserver)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.makeTodo()
        }

        scheduler.start()

        XCTAssertEqual(isLoadingObserver.events.count, 5)
        let initialLoadingEvent = isLoadingObserver.events[0]
        XCTAssertEqual(initialLoadingEvent.time, 0)
        XCTAssertFalse(initialLoadingEvent.value.element!)

        let isLoadingOneEvent = isLoadingObserver.events[1]
        XCTAssertEqual(isLoadingOneEvent.time, 1)
        XCTAssertTrue(isLoadingOneEvent.value.element!)

        let isLoadingTwoEvent = isLoadingObserver.events[2]
        XCTAssertEqual(isLoadingTwoEvent.time, 1)
        XCTAssertTrue(isLoadingTwoEvent.value.element!)

        let finishedLoadingOneEvent = isLoadingObserver.events[3]
        XCTAssertEqual(finishedLoadingOneEvent.time, 1)
        XCTAssertFalse(finishedLoadingOneEvent.value.element!)

        let finishedLoadingTwoEvent = isLoadingObserver.events[4]
        XCTAssertEqual(finishedLoadingTwoEvent.time, 1)
        XCTAssertFalse(finishedLoadingTwoEvent.value.element!)


        XCTAssertEqual(todosObserver.events.count, 2)
        let initialTodosEvent = todosObserver.events[0]
        XCTAssertEqual(initialTodosEvent.time, 0)
        XCTAssertEqual(initialTodosEvent.value.element!, [])

        let loadedTodosEvent = todosObserver.events[1]
        XCTAssertEqual(loadedTodosEvent.time, 1)
        XCTAssertEqual(loadedTodosEvent.value.element!, [expectedTodo])
    }

    func testThat_it_does_not_make_todo_because_of_a_bad_response() {
        testApiService.error = .badResult

        let isLoadingObserver = scheduler.createObserver(Bool.self)
        let todosObserver = scheduler.createObserver([Todo].self)

        scheduler.scheduleAt(0) {
            self.loadingSubscription = self.viewModel.isLoading.asObservable().subscribe(isLoadingObserver)
            self.todosSubscription = self.viewModel.todos.asObservable().subscribe(todosObserver)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.makeTodo()
        }

        scheduler.start()

        XCTAssertEqual(isLoadingObserver.events.count, 3)
        let initialLoadingEvent = isLoadingObserver.events[0]
        XCTAssertEqual(initialLoadingEvent.time, 0)
        XCTAssertFalse(initialLoadingEvent.value.element!)

        let isLoadingEvent = isLoadingObserver.events[1]
        XCTAssertEqual(isLoadingEvent.time, 1)
        XCTAssertTrue(isLoadingEvent.value.element!)

        let finishedLoadingEvent = isLoadingObserver.events[2]
        XCTAssertEqual(finishedLoadingEvent.time, 1)
        XCTAssertFalse(finishedLoadingEvent.value.element!)


        XCTAssertEqual(todosObserver.events.count, 1)
        let initialTodosEvent = todosObserver.events[0]
        XCTAssertEqual(initialTodosEvent.time, 0)
        XCTAssertEqual(initialTodosEvent.value.element!, [])
    }
}
