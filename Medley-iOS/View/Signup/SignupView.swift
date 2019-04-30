//
//  SignupView.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol SignupView: UIViewController, Storyboarded {
    var viewModel: SignupVM! { get }
}
