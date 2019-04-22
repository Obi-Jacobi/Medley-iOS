//
//  APIService.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation

struct SignupRequest: Encodable {
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

protocol ApiService {
    typealias APIServiceCompletion<Type> = (Result<APIResponse<Type>, APIError>) -> Void

    func signup(request signupRequest: SignupRequest, _ completion: @escaping APIServiceCompletion<SignupResponse>) throws
    func login()
    func getAllTodos()
    func makeTodo()
}
