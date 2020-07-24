 //
//  TodoCell.swift
//  TableView
//
//  Created by 刘皇逊 on 4/11/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todo: UILabel!
    @IBOutlet weak var checkMark: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
