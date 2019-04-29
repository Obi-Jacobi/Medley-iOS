//
//  APIClient.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?

    init(method: HTTPMethod, path: String, loginRequest: LoginRequest) throws {
        self.method = method
        self.path = path

        let authString = "\(loginRequest.email):\(loginRequest.password)"
        let authData = authString.data(using: .utf8)!
        let authValue = "Basic \(authData.base64EncodedString())"
        self.headers = [HTTPHeader(field: "Authorization", value: authValue)]
    }

    init<Body: Encodable>(method: HTTPMethod, path: String, body: Body) throws {
        self.method = method
        self.path = path

        self.body = try JSONEncoder().encode(body)
        self.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
    }
}

struct ApiClient: ApiService {

    private let baseURL = URL(string: "http://localhost:8080")

    func signup(request signupRequest: SignupRequest, _ completion: @escaping (Result<SignupResponse, Error>) -> Void) throws {
        let apiRequest = try APIRequest(method: .post, path: "users", body: signupRequest)
        let request = urlRequest(from: apiRequest)!

        AF.request(request).responseDecodable { (response: DataResponse<SignupResponse>) in
            completion(response.result)
        }
    }

    func login(request loginRequest: LoginRequest, _ completion: @escaping (Result<LoginResponse, Error>) -> Void) throws {
        let apiRequest = try APIRequest(method: HTTPMethod.post, path: "login", loginRequest: loginRequest)
        let request = urlRequest(from: apiRequest)!

        AF.request(request).responseDecodable { (response: DataResponse<LoginResponse>) in
            completion(response.result)
        }
    }

    func getAllTodos() {

    }

    func makeTodo() {

    }

    private func urlRequest(from request: APIRequest) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL?.scheme
        urlComponents.host = baseURL?.host
        urlComponents.port = baseURL?.port
        urlComponents.path = baseURL?.path ?? ""
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.field)
        }

        return urlRequest
    }
}
