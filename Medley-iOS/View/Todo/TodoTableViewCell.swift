//
//  TodoTableViewCell.swift
//  Medley-iOS
//
//  Created by Jacob Wilson on 4/30/19.
//  Copyright © 2019 Jacob Wilson. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(from todo: Todo) {
        titleLabel.text = todo.title
    }
    
}
