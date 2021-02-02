//
//  customCell.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var albumArtwork: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
