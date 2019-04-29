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
                XCTAssertEqual(response.body, expectedResponse)
            case .failure:
                XCTFail("Should not be called")
            }

            testExpecation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

//    func testThat_client_returns_error_when_bad_network_response() {
//        let testExpecation = expectation(description: #function)
//
//        stub(condition: isScheme("http") && isHost(host) && isPath("/users")) { thing in
//            let response = SignupResponse(id: 1, name: "name", email: "email")
//            let json = try! JSONEncoder().encode(response)
//            return OHHTTPStubsResponse(data: json, statusCode: 400, headers: nil)
//        }
//
//        let request = SignupRequest(name: "name", email: "email", password: "password", verifyPassword: "password")
//
//        try! client.signup(request: request) { result in
//            let expectedResponse = SignupResponse(id: 1, name: "name", email: "email")
//
//            switch result {
//            case .success:
////                XCTAssertEqual(response.body, expectedResponse)
//                XCTFail("Should not be called")
//            case .failure(let error):
//                XCTAssertEqual(error, APIError.requestFailed)
//            }
//
//            testExpecation.fulfill()
//        }
//
//        waitForExpectations(timeout: 3, handler: nil)
//    }
}
