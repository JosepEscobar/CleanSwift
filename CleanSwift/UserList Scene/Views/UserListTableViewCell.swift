//
//  UserListTableViewCell.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String, avatarUrl: String) {
        self.nameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
