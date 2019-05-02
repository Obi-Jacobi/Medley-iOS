//
//  SignupViewModelTests.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 4/30/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Medley_iOS

class SignupViewModelTests: XCTestCase {

    var testApiService: TestApiService!
    var testAuthCoordinator: TestAuthCoordinator!

    var scheduler: TestScheduler!
    var subscription: Disposable!

    var viewModel: SignupViewModel!

    override func setUp() {
        super.setUp()

        testApiService = TestApiService()
        testAuthCoordinator = TestAuthCoordinator()

        scheduler = TestScheduler(initialClock: 0)

        viewModel = SignupViewModel(apiService: testApiService, coordinator: testAuthCoordinator)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        scheduler = nil
        subscription?.dispose()
        subscription = nil
    }

    func testThat_it_navigates_toLogin() {
        XCTAssertFalse(testAuthCoordinator.loginCalled)

        viewModel.navigateToLogin()

        XCTAssertTrue(testAuthCoordinator.loginCalled)
    }

    func testThat_it_signs_up_correctly() {
        testApiService.signupResponse = SignupResponse(id: 1, name: "name", email: "email")

        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            XCTAssertFalse(self.testAuthCoordinator.successfulSignupCalled)
            self.subscription = self.viewModel.isLoading.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.signup()
        }

        scheduler.scheduleAt(2) {
            XCTAssertTrue(self.testAuthCoordinator.successfulSignupCalled)
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

    func testThat_it_does_not_sign_up_because_of_a_bad_response() {
        testApiService.error = .badResult

        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            XCTAssertFalse(self.testAuthCoordinator.successfulSignupCalled)
            self.subscription = self.viewModel.isLoading.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.signup()
        }

        scheduler.scheduleAt(2) {
            XCTAssertFalse(self.testAuthCoordinator.successfulSignupCalled)
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

    func testThat_SignupBecomesEnabledWhenAllFieldsAreNotEmpty() {
        let observer = scheduler.createObserver(Bool.self)

        scheduler.scheduleAt(0) {
            self.subscription = self.viewModel.signupEnabled.asObservable().subscribe(observer)
        }

        scheduler.scheduleAt(1) {
            self.viewModel.nameChanged("Name")
            self.viewModel.emailChanged("Email")
        }

        scheduler.scheduleAt(2) {
            self.viewModel.nameChanged("New Name")
            self.viewModel.passwordChanged("password")
        }

        scheduler.scheduleAt(3) {
            self.viewModel.verifyPasswordChanged("not password")
        }

        scheduler.scheduleAt(4) {
            self.viewModel.emailChanged("")
        }

        scheduler.scheduleAt(5) {
            self.viewModel.verifyPasswordChanged("")
        }

        scheduler.scheduleAt(6) {
            self.viewModel.emailChanged("EMAIL")
            self.viewModel.verifyPasswordChanged("PASSWORD")
        }

        scheduler.scheduleAt(7) {
            self.viewModel.nameChanged("")
        }

        scheduler.scheduleAt(8) {
            self.viewModel.nameChanged("NAME")
        }

        scheduler.start()

        XCTAssertEqual(observer.events.count, 12)

        let initialEvent = observer.events[0]
        XCTAssertEqual(initialEvent.time, 0)
        XCTAssertFalse(initialEvent.value.element!)

        let twoEvent = observer.events[1]
        XCTAssertEqual(twoEvent.time, 1)
        XCTAssertFalse(twoEvent.value.element!)

        let threeEvent = observer.events[2]
        XCTAssertEqual(threeEvent.time, 1)
        XCTAssertFalse(threeEvent.value.element!)

        let fourEvent = observer.events[3]
        XCTAssertEqual(fourEvent.time, 2)
        XCTAssertFalse(fourEvent.value.element!)

        let fiveEvent = observer.events[4]
        XCTAssertEqual(fiveEvent.time, 2)
        XCTAssertFalse(fiveEvent.value.element!)

        let sixEvent = observer.events[5]
        XCTAssertEqual(sixEvent.time, 3)
        XCTAssertTrue(sixEvent.value.element!)

        let sevenEvent = observer.events[6]
        XCTAssertEqual(sevenEvent.time, 4)
        XCTAssertFalse(sevenEvent.value.element!)

        let eightEvent = observer.events[7]
        XCTAssertEqual(eightEvent.time, 5)
        XCTAssertFalse(eightEvent.value.element!)

        let nineEvent = observer.events[8]
        XCTAssertEqual(nineEvent.time, 6)
        XCTAssertFalse(nineEvent.value.element!)

        let tenEvent = observer.events[9]
        XCTAssertEqual(tenEvent.time, 6)
        XCTAssertTrue(tenEvent.value.element!)

        let elevenEvent = observer.events[10]
        XCTAssertEqual(elevenEvent.time, 7)
        XCTAssertFalse(elevenEvent.value.element!)

        let lastEvent = observer.events[11]
        XCTAssertEqual(lastEvent.time, 8)
        XCTAssertTrue(lastEvent.value.element!)
    }
}
