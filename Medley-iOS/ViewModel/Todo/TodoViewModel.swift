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
    // Inputs
    func getTodos()
    func makeTodo()

    // Outputs
    var isLoading: Driver<Bool> { get }
    var todos: Driver<[Todo]> { get }
}

class TodoViewModel: TodoVM {

    let isLoading: Driver<Bool>
    let todos: Driver<[Todo]>
    private let _todos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])

    private let apiService: ApiService
    private weak var coordinator: TodoCoordinatable?

    init(apiService: ApiService,
         coordinator: TodoCoordinatable) {

        self.apiService = apiService
        self.coordinator = coordinator

        self.isLoading = loading.asDriver(onErrorJustReturn: false)
        self.todos = _todos.asDriver()
    }

    private let loading = BehaviorRelay(value: false)

    func getTodos() {
        loading.accept(true)
        try? apiService.getAllTodos { result in
            switch result {
            case .success(let response):
                self._todos.accept(response)
            case .failure(let error):
                print("Error performing login request \(error)")
            }
            self.loading.accept(false)
        }
    }

    func makeTodo() {
        let todoRequest = TodoRequest(title: "new todo")

        loading.accept(true)
        try? apiService.makeTodo(request: todoRequest) { result in
            switch result {
            case .success:
                self.getTodos()
            case .failure(let error):
                print("Error performing login request \(error)")
            }
            self.loading.accept(false)
        }
    }
}
