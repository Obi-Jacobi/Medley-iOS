//
//  APIService.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation

struct SignupResponse: Codable {
    let id: Int
    let name: String
    let email: String
}

protocol ApiService {
    typealias APIClientCompletion<Type> = (Result<APIResponse<Type>, APIError>) -> Void

    func signup(_ completion: @escaping APIClientCompletion<SignupResponse>) throws
    func login()
    func getAllTodos()
    func makeTodo()
}
