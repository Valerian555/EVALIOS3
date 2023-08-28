//
//  CryptoImageViewController.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import UIKit
import Alamofire

class CryptoImageViewController:
    UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var cryptoImageTableView: UITableView!
    var cryptoImageList = [CryptoImage]()
    
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCall()
        
        //tableView setup
        cryptoImageTableView.delegate = self
        cryptoImageTableView.dataSource = self
        cryptoImageTableView.register(UINib(nibName: "CryptoImageTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "CryptoImageTableViewCell")
    }
    
    //MARK: Network
    func networkCall() {
        AF.request("https://api.coinstats.app/public/v1/coins?skip=0&limit=50&currency=EUR").response { response in
            switch response.result {
                
            case.success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                
                do {
                    let cryptoImageResponse = try decoder.decode(CryptoImageResponse.self, from: data)
                    
                    self.cryptoImageList.append(contentsOf: cryptoImageResponse.coins)
                    self.cryptoImageTableView.reloadData()
                    
                } catch {
                    print("Error, can't parse JSON.")
                }
            case.failure(let error): print("Error, can't download. (error = \(error)")
            }
        }
    }
}

//MARK: TableView Extension
extension CryptoImageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier:
                                                        "CryptoImageTableViewCell", for: indexPath) as! CryptoImageTableViewCell

        customCell.setup(crypto: cryptoImageList[indexPath.row])
        
        return customCell
    }
}
