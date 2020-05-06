//
//  ZoneViewCell.swift
//  LifeLine
//
//  Created by Stephen Baity on 5/1/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ZoneViewCell: UITableViewCell {

	@IBOutlet var zoneName: UILabel!
    
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
