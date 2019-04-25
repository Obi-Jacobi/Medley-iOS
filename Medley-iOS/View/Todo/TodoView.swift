//
//  TodoView.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/25/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol TodoView: UIViewController, Storyboarded {
    var viewModel: TodoViewModel! { get }
}
