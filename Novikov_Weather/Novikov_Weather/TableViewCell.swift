//
//  TableViewCell.swift
//  Novikov_Weather
//
//  Created by wsr on 15.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
