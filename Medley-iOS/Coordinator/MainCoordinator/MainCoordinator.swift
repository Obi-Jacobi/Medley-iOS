//
//  MainCoordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init() {
        let vc = ViewController.instantiate(from: "Main")
        self.navigationController = UINavigationController(rootViewController: vc)
    }

    func start() {
//        let vc = ViewController.instantiate(from: "Main")
//        //navigationController.pushViewController(vc, animated: false)
//
//        navigationController.
    }
}
