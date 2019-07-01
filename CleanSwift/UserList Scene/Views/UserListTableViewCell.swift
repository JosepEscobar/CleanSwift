//
//  UserListTableViewCell.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(name: String, avatarUrl: String, email: String, phone: String) {
        nameLabel.text = name
        emailLabel.text = email
        phoneLabel.text = phone
        if let url = URL(string: avatarUrl) {
            avatarImageView.kf.setImage(with: url)
        }
        setCircleAvatar()
    }

    func setCircleAvatar() {
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
