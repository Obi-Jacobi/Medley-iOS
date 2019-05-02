//
//  TodoViewController.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/22/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoViewController: UIViewController, TodoView {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var makeTodoBarButton: UIBarButtonItem!

    var viewModel: TodoVM!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        setupBindings()

        viewModel.getTodos()
    }

    private func setupBindings() {
        makeTodoBarButton.rx.tap.asObservable().subscribe(onNext: viewModel.makeTodo).disposed(by: disposeBag)

        viewModel.todos.drive(tableView.rx.items(cellIdentifier: "TodoCell", cellType: TodoTableViewCell.self)) { index, viewModel, cell in
            cell.configure(from: viewModel)
        }.disposed(by: disposeBag)

        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            print("Item Deleted \(indexPath)")
        }).disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Item Selected \(indexPath)")
        }).disposed(by: disposeBag)
    }
}
