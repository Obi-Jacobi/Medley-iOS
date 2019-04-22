//
//  Assembly.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignupViewModel.self) { (r: Resolver, goToLogin: @escaping () -> Void) in
            let apiService = r.resolve(ApiService.self)!
            return SignupViewModel(apiService: apiService, goToLogin: goToLogin)
        }.inObjectScope(.transient)
        
    }
}
