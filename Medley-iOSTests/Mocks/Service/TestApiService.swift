//
//  TestApiService.swift
//  Medley-iOSTests
//
//  Created by Jacob Wilson on 4/30/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

@testable import Medley_iOS

class TestApiService: ApiService {
    enum ApiError: Error {
        case badResult
    }

    var error: ApiError? = nil

    var signupResponse: SignupResponse?
    func signup(request signupRequest: SignupRequest, _ completion: @escaping (Result<SignupResponse, Error>) -> Void) throws {
        guard let signupResponse = signupResponse, error == nil else {
            completion(.failure(error!))
            return
        }

        completion(.success(signupResponse))
    }

    var loginResponse: LoginResponse?
    func login(request loginRequest: LoginRequest, _ completion: @escaping (Result<LoginResponse, Error>) -> Void) throws {
        guard let loginResponse = loginResponse, error == nil else {
            completion(.failure(error!))
            return
        }

        completion(.success(loginResponse))
    }

    var allTodos: [Todo]?
    func getAllTodos(_ completion: @escaping (Result<[Todo], Error>) -> Void) throws {
        guard let allTodos = allTodos, error == nil else {
            completion(.failure(error!))
            return
        }

        completion(.success(allTodos))
    }

    var madeTodo: Todo?
    func makeTodo(request todoRequest: TodoRequest, _ completion: @escaping (Result<Todo, Error>) -> Void) throws {
        guard let madeTodo = madeTodo, error == nil else {
            completion(.failure(error!))
            return
        }

        completion(.success(madeTodo))
    }
}
