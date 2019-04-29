//
//  TodoViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/25/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift

class TodoViewModel {

    private let apiService: ApiService
    private weak var coordinator: TodoCoordinatable?

    private let disposeBag = DisposeBag()

    init(apiService: ApiService,
         coordinator: TodoCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator
    }

    func getTodos() {
        try? apiService.getAllTodos { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print("Error performing login request \(error)")
            }
        }
    }

    func makeTodo() {
        let todoRequest = TodoRequest(title: "new todo")

        try? apiService.makeTodo(request: todoRequest) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print("Error performing login request \(error)")
            }
        }
    }
}
