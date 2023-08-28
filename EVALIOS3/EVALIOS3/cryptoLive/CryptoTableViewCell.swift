//
//  CryptoTableViewCell.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import UIKit
import SafariServices

class CryptoTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var explorerButton: UIButton!
    @IBOutlet weak var cryptoPriceUSD: UILabel!
    @IBOutlet weak var cryptoChangePercent24Hr: UILabel!
    @IBOutlet weak var cryptoRank: UILabel!
    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var yellowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        yellowView.layer.cornerRadius = yellowView.frame.width / 2
        yellowView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func setup(crypto: Crypto){
        cryptoName.text = crypto.id
        cryptoRank.text = crypto.rank
        cryptoChangePercent24Hr.text = formatedPercent(percent: crypto.changePercent24Hr ?? "") 
        cryptoPriceUSD.text = formattedPrice(priceUsd: crypto.priceUsd ?? "")

    }
    
    func formatedPercent(percent: String) -> String? {
        if let decimalValue = Double(percent) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .percent
                formatter.maximumFractionDigits = 2 // Nombre de chiffres après la virgule
            
            if decimalValue >= 0 {
                cryptoChangePercent24Hr.textColor = .green
            } else {
                cryptoChangePercent24Hr.textColor = .red
            }
                
                if let formatted = formatter.string(from: NSNumber(value: decimalValue / 100)) {
                    return formatted
                }
            }
        
            return "0%" // Valeur par défaut
    }
}
