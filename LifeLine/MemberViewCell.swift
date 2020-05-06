//
//  MemberViewCell.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import Alamofire
import UIKit

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: AnyObject)
}

class MemberViewCell: UITableViewCell {
    
    var delegate:MyCustomCellDelegator!

	@IBOutlet var picture: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var phoneLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var zonesBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
