//
//  Coordinator.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

// https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start()
}
