//
//  FirstTest.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 4/25/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Medley_iOS

class ApiClientTests: XCTestCase {

    enum TestError: Error {
        case badResponse
    }

    var client: ApiClient!

    let host = "localhost"

    override func setUp() {
        super.setUp()

        client = ApiClient()
    }

    override func tearDown() {
        super.tearDown()

        client = nil
        OHHTTPStubs.removeAllStubs()
    }

    func testThat_client_signup_response_is_valid() {
        let testExpecation = expectation(description: #function)

        stub(condition: isScheme("http") && isHost(host) && isPath("/users")) { thing in
            let response = SignupResponse(id: 1, name: "name", email: "email")
            let json = try! JSONEncoder().encode(response)
            return OHHTTPStubsResponse(data: json, statusCode: 200, headers: nil)
        }

        let request = SignupRequest(name: "name", email: "email", password: "password", verifyPassword: "password")

        try! client.signup(request: request) { result in
            let expectedResponse = SignupResponse(id: 1, name: "name", email: "email")

            switch result {
            case .success(let response):
                XCTAssertEqual(response, expectedResponse)
            case .failure:
                XCTFail("Should not be called")
            }

            testExpecation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testThat_client_returns_error_when_bad_network_response_for_signup() {
        let testExpecation = expectation(description: #function)

        stub(condition: isScheme("http") && isHost(host) && isPath("/users")) { thing in
            return OHHTTPStubsResponse(error: TestError.badResponse)
        }

        let request = SignupRequest(name: "name", email: "email", password: "password", verifyPassword: "password")

        try! client.signup(request: request) { result in
            switch result {
            case .success:
                XCTFail("Should not be called")
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            testExpecation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testThat_client_login_response_is_valid() {
        let testExpecation = expectation(description: #function)

        stub(condition: isScheme("http") && isHost(host) && isPath("/login")) { thing in
            let response = LoginResponse(id: 1, string: "name", userID: 1, expiresAt: "idk")
            let json = try! JSONEncoder().encode(response)
            return OHHTTPStubsResponse(data: json, statusCode: 200, headers: nil)
        }

        let request = LoginRequest(email: "email", password: "password")

        try! client.login(request: request) { result in
            let expectedResponse = LoginResponse(id: 1, string: "name", userID: 1, expiresAt: "idk")

            switch result {
            case .success(let response):
                XCTAssertEqual(response, expectedResponse)
            case .failure:
                XCTFail("Should not be called")
            }

            testExpecation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testThat_client_returns_error_when_bad_network_response_for_login() {
        let testExpecation = expectation(description: #function)

        stub(condition: isScheme("http") && isHost(host) && isPath("/login")) { thing in
            return OHHTTPStubsResponse(error: TestError.badResponse)
        }

        let request = LoginRequest(email: "email", password: "password")

        try! client.login(request: request) { result in
            switch result {
            case .success:
                XCTFail("Should not be called")
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            testExpecation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }
}
