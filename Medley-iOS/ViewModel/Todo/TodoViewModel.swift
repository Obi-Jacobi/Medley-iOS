//
//  TodoViewModel.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/25/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import RxSwift
import RxCocoa

protocol TodoVM {
    var todos: Driver<[Todo]> { get }

    func getTodos()
    func makeTodo()
}

class TodoViewModel: TodoVM {

    let todos: Driver<[Todo]>
    private let _todos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])

    private let apiService: ApiService
    private weak var coordinator: TodoCoordinatable?

    init(apiService: ApiService,
         coordinator: TodoCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator

        self.todos = _todos.asDriver()
    }

    func getTodos() {
        try? apiService.getAllTodos { result in
            switch result {
            case .success(let response):
                print(response)
                self._todos.accept(response)
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
                self.getTodos()
            case .failure(let error):
                print("Error performing login request \(error)")
            }
        }
    }
}
