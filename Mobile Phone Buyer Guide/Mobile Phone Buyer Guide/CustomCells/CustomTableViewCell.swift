//
//  CustomTableViewCell.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mProductName:UILabel!
    @IBOutlet weak var mProductDescription:UILabel!
    @IBOutlet weak var mProductPrice:UILabel!
    @IBOutlet weak var mProductRate:UILabel!
    @IBOutlet weak var mProductImage:UIImageView!
    @IBOutlet weak var mFavoriteButton:UIButton!
    
    weak var delegate: MyCellDelegate?
    
    @IBAction func didTapButton(sender: UIButton) {
//        print(sender.tag)
        delegate?.didTapButtonInCell(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
