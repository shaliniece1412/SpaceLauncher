//
//  LauchTableViewCell.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import UIKit

class LauchTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var userStatusLbl: UILabel!
    @IBOutlet weak var wikiLinkLbl: UILabel!
    @IBOutlet weak var lastFlightLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
