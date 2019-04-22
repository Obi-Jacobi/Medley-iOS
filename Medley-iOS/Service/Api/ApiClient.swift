//
//  APIClient.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
}

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

    init<Body: Encodable>(method: HTTPMethod, path: String, body: Body? = nil) throws {
        self.method = method
        self.path = path

        guard let body = body else {
            return
        }

        self.body = try JSONEncoder().encode(body)
        self.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
    }
}

struct APIResponse<Body> {
    let statusCode: Int
    let body: Body
}

struct ApiClient: ApiService {

    private let session = URLSession.shared
    private let baseURL = URL(string: "http://localhost:8080")

    func signup(request signupRequest: SignupRequest, _ completion: @escaping APIServiceCompletion<SignupResponse>) throws {
        let apiRequest = try APIRequest(method: .post, path: "users", body: signupRequest)
        request(apiRequest, decodeTo: SignupResponse.self, completion)
    }

    func login() {

    }

    func getAllTodos() {

    }

    func makeTodo() {

    }

    private func request<Type: Codable>(_ request: APIRequest, decodeTo: Type.Type, _ completion: @escaping APIServiceCompletion<Type>) {

        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL?.scheme
        urlComponents.host = baseURL?.host
        urlComponents.port = baseURL?.port
        urlComponents.path = baseURL?.path ?? ""
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(.failure(.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.field)
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data,
                let decoded = try? JSONDecoder().decode(Type.self, from: data) else {

                    completion(.failure(.decodingFailure))
                    return
            }

            completion(.success(APIResponse<Type>(statusCode: httpResponse.statusCode, body: decoded)))
        }

        task.resume()
    }
}
