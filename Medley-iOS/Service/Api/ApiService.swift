//
//  APIService.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation

struct SignupRequest: Codable {
    var name: String
    var email: String
    var password: String
    var verifyPassword: String
}

struct SignupResponse: Codable {
    let id: Int
    let name: String
    let email: String
}
extension SignupResponse: Equatable { }

struct LoginRequest: Codable {
    var email: String
    var password: String
}

struct LoginResponse: Codable {
    let id: Int
    let string: String
    let userID: Int
    let expiresAt: String
}
extension LoginResponse: Equatable { }

struct Todo: Codable {
    let id: Int
    let title: String
    let userID: Int
}

struct TodoRequest: Codable {
    let title: String
}

protocol ApiService {
    func signup(request signupRequest: SignupRequest, _ completion: @escaping (Result<SignupResponse, Error>) -> Void) throws
    func login(request loginRequest: LoginRequest, _ completion: @escaping (Result<LoginResponse, Error>) -> Void) throws
    func getAllTodos(_ completion: @escaping (Result<[Todo], Error>) -> Void) throws
    func makeTodo(request todoRequest: TodoRequest, _ completion: @escaping (Result<Todo, Error>) -> Void) throws
}
