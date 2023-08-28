//
//  CryptoResponse.swift
//  EVALIOS3
//
//  Created by Student08 on 28/08/2023.
//

import Foundation

struct CryptoResponse: Codable {
    let data: [Crypto]
}

struct Crypto: Codable {
    let id: String?
    let rank: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let explorer: String?
}

struct PriceHistoryResponse: Codable {
    let data: [PriceHistory]
}

struct PriceHistory: Codable {
    let priceUsd: String?
    let date: String?
}

struct CryptoImageResponse: Codable {
    let coins: [CryptoImage]
}

struct CryptoImage: Codable {
    let name: String?
    let icon: String?
}

