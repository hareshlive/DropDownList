//
//  UserListCell.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets.zero
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserData(result:Result?) {
        if let userResult = result {
            lblFullName.text = "\(userResult.firstname ?? "") \(userResult.lastname ?? "")"
            lblEmail.text = userResult.email ?? ""
            lblMobileNo.text = userResult.mobileno ?? ""
        }
    }
    
}
