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
}
