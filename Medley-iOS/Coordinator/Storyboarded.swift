//
//  Storyboarded.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/19/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(from storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboard: String) -> Self {
//        // this pulls out "MyApp.MyViewController"
//        let fullName = NSStringFromClass(self)
//
//        // this splits by the dot and uses everything after, giving "MyViewController"
//        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateInitialViewController() as! Self
    }
}
