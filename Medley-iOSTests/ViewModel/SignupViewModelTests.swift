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
}
