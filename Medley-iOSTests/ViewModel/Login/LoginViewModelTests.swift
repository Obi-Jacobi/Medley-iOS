//
//  LoginViewModelTests.swift
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

class LoginViewModelTests: XCTestCase {

    var testApiService: TestApiService!
    var testAuthService: TestAuthService!
    var testAuthCoordinator: TestAuthCoordinator!

    var scheduler: TestScheduler!
    var subscription: Disposable!

    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()

        testApiService = TestApiService()
        testAuthService = TestAuthService()
        testAuthCoordinator = TestAuthCoordinator()

        scheduler = TestScheduler(initialClock: 0)

        viewModel = LoginViewModel(apiService: testApiService, authService: testAuthService, coordinator: testAuthCoordinator)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        scheduler = nil
        subscription?.dispose()
        subscription = nil
    }

    func testThat_it_navigates_toSignup() {
        XCTAssertFalse(testAuthCoordinator.signupCalled)

        viewModel.navigateToSignup()

        XCTAssertTrue(testAuthCoordinator.signupCalled)
    }

    func testThat_it_logins_correctly() {
        testApiService.loginResponse = LoginResponse(id: 1, string: "token", userID: 1, expiresAt: "date")

        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            XCTAssertFalse(self.testAuthCoordinator.successfulLoginCalled)
            self.subscription = self.viewModel.isLoading.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.login()
        }

        scheduler.scheduleAt(2) {
            XCTAssertTrue(self.testAuthCoordinator.successfulLoginCalled)
        }

        scheduler.start()

        XCTAssertEqual(observer.events.count, 3)

        let initialEvent = observer.events[0]
        XCTAssertEqual(initialEvent.time, 0)
        XCTAssertFalse(initialEvent.value.element!)

        let isLoadingEvent = observer.events[1]
        XCTAssertEqual(isLoadingEvent.time, 1)
        XCTAssertTrue(isLoadingEvent.value.element!)

        let finishedEvent = observer.events[2]
        XCTAssertEqual(finishedEvent.time, 1)
        XCTAssertFalse(finishedEvent.value.element!)
    }

    func testThat_it_does_not_login_because_of_a_bad_response() {
        testApiService.error = .badResult

        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            XCTAssertFalse(self.testAuthCoordinator.successfulLoginCalled)
            self.subscription = self.viewModel.isLoading.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.login()
        }

        scheduler.scheduleAt(2) {
            XCTAssertFalse(self.testAuthCoordinator.successfulLoginCalled)
        }

        scheduler.start()

        XCTAssertEqual(observer.events.count, 3)

        let initialEvent = observer.events[0]
        XCTAssertEqual(initialEvent.time, 0)
        XCTAssertFalse(initialEvent.value.element!)

        let isLoadingEvent = observer.events[1]
        XCTAssertEqual(isLoadingEvent.time, 1)
        XCTAssertTrue(isLoadingEvent.value.element!)

        let finishedEvent = observer.events[2]
        XCTAssertEqual(finishedEvent.time, 1)
        XCTAssertFalse(finishedEvent.value.element!)
    }

    func testThat_LoginBecomesEnabledWhenAllFieldsAreNotEmpty() {
        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            self.subscription = self.viewModel.loginEnabled.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.emailChanged("Email")
        }

        scheduler.scheduleAt(2) {
            self.viewModel.passwordChanged("password")
        }

        scheduler.scheduleAt(3) {
            self.viewModel.emailChanged("")
        }

        scheduler.scheduleAt(4) {
            self.viewModel.passwordChanged("")
        }

        scheduler.scheduleAt(5) {
            self.viewModel.emailChanged("")
            self.viewModel.passwordChanged("password")
        }

        scheduler.scheduleAt(6) {
            self.viewModel.emailChanged("EMAIL")
            self.viewModel.passwordChanged("PASSWORD")
        }

        scheduler.start()

        XCTAssertEqual(observer.events.count, 9)

        let initialEvent = observer.events[0]
        XCTAssertEqual(initialEvent.time, 0)
        XCTAssertFalse(initialEvent.value.element!)

        let twoEvent = observer.events[1]
        XCTAssertEqual(twoEvent.time, 1)
        XCTAssertFalse(twoEvent.value.element!)

        let threeEvent = observer.events[2]
        XCTAssertEqual(threeEvent.time, 2)
        XCTAssertTrue(threeEvent.value.element!)

        let fourEvent = observer.events[3]
        XCTAssertEqual(fourEvent.time, 3)
        XCTAssertFalse(fourEvent.value.element!)

        let fiveEvent = observer.events[4]
        XCTAssertEqual(fiveEvent.time, 4)
        XCTAssertFalse(fiveEvent.value.element!)

        let sixEvent = observer.events[5]
        XCTAssertEqual(sixEvent.time, 5)
        XCTAssertFalse(sixEvent.value.element!)

        let sevenEvent = observer.events[6]
        XCTAssertEqual(sevenEvent.time, 5)
        XCTAssertFalse(sevenEvent.value.element!)

        let eightEvent = observer.events[7]
        XCTAssertEqual(eightEvent.time, 6)
        XCTAssertTrue(eightEvent.value.element!)

        let lastEvent = observer.events[8]
        XCTAssertEqual(lastEvent.time, 6)
        XCTAssertTrue(lastEvent.value.element!)
    }
}
