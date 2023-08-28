//
//  DetailsTableViewCell.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var priceUsd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(priceHistory: PriceHistory) {
        date.text = formattedDate(date: priceHistory.date ?? "error")
        priceUsd.text = formattedPrice(priceUsd: priceHistory.priceUsd ?? "error")
    }
    
}
