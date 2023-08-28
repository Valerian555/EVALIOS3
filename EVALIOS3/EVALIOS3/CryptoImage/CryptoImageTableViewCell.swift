//
//  CryptoImageTableViewCell.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//
import UIKit
import AlamofireImage
import Alamofire

class CryptoImageTableViewCell: UITableViewCell {
    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var cryptoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setup(crypto: CryptoImage) {
        cryptoName.text = crypto.name
        cryptoImage.af.setImage(withURL: URL(string: crypto.icon!)!)
    }
}
