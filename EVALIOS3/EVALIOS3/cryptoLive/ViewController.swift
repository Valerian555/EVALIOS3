//
//  ViewController.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var cryptoTableView: UITableView!
    var cryptoList = [Crypto]()
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    let refreshControl = UIRefreshControl()
    
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CryptoLive"
        
        networkCall()
        
        //setup de la tableView
        cryptoTableView.delegate = self
        cryptoTableView.dataSource = self
        cryptoTableView.register(UINib(nibName: "CryptoTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "CryptoTableViewCell")
        
        //gérer le refresh de la tableView
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        cryptoTableView.refreshControl = refreshControl
        
        mySegmentedControl.addTarget(self, action:
            #selector(segmentedControlChange(segmentedControl:)), for: .valueChanged)
    }
    
    //MARK: Network
    func networkCall() {
        AF.request("https://api.coincap.io/v2/assets").response { response in
            switch response.result {
                
            case.success(let data):
                guard let data else { return }
                let decoder = JSONDecoder()
                
                do {
                    let cryptoResponse = try decoder.decode(CryptoResponse.self, from: data)
                    
                    self.cryptoList = cryptoResponse.data
                    
                    self.refreshControl.endRefreshing()
                    
                    DispatchQueue.main.async {
                            self.cryptoTableView.reloadData()
                        }
                } catch {
                    print("Error, can't parse JSON.")
                }
            case.failure(let error): print("Error, can't download. (error = \(error)")
            }
        }
    }
    
    @objc func segmentedControlChange(segmentedControl: UISegmentedControl)
        {
        //code lorsque l'on choisit un segment
            
    }
    
    @objc func refreshData() {
        networkCall()
    }
}

//MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier:
                                                        "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
        
        customCell.setup(crypto: cryptoList[indexPath.row])
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //instancier le ViewController de destination
        if let cryptoDetailsViewController = storyboard?.instantiateViewController(identifier: "CryptoDetailsViewController") as? CryptoDetailsViewController {
            
            //passage de données
            cryptoDetailsViewController.crypto = cryptoList[indexPath.row]
            
            //méthode permettant la navigation
            navigationController?.pushViewController(cryptoDetailsViewController, animated: true)
        }
    }
}

