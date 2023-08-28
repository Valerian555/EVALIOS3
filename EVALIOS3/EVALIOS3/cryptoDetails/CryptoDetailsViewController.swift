//
//  CryptoDetailsViewController.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import UIKit
import Alamofire

class CryptoDetailsViewController: UIViewController {
    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var cryptoPrice: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    var crypto: Crypto?
    var priceHistoryList = [PriceHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        networkCall()
        

        cryptoName.text = crypto?.id
        cryptoPrice.text = formattedPrice(priceUsd: crypto?.priceUsd ?? "error")
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        detailsTableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "DetailsTableViewCell")
        
        print(priceHistoryList)
    }
    
    func networkCall() {
        AF.request("https://api.coincap.io/v2/assets/\(crypto?.id ?? "bitcoin")/history?interval=d1").response { response in
            switch response.result {
                
            case.success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                
                do {
                    let priceHistoryResponse = try decoder.decode(PriceHistoryResponse.self, from: data)
                    
                    self.priceHistoryList.append(contentsOf: priceHistoryResponse.data)
                    self.detailsTableView.reloadData()
                    
                } catch {
                    print("Error, can't parse JSON.")
                }
            case.failure(let error): print("Error, can't download. (error = \(error)")
            }
        }
    }
}

extension CryptoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        priceHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier:
                                                        "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell

        customCell.setup(priceHistory: priceHistoryList.reversed()[indexPath.row])
        
        return customCell
    }
    
    
}
