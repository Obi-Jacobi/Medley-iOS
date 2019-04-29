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

protocol ApiService {
    typealias APIServiceCompletion<Type> = (Result<APIResponse<Type>, APIError>) -> Void

    func signup(request signupRequest: SignupRequest, _ completion: @escaping APIServiceCompletion<SignupResponse>) throws
    func login(request loginRequest: LoginRequest, _ completion: @escaping APIServiceCompletion<LoginResponse>) throws
    func getAllTodos()
    func makeTodo()
}
