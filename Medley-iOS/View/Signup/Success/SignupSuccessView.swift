//
//  SignupSuccessView.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/23/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

protocol SignupSuccessView: UIViewController, Storyboarded {
    var viewModel: SignupSuccessVM! { get }
}
