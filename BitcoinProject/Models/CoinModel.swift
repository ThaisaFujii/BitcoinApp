//
//  CoinModel.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/24/22.
//

import Foundation

// estruturas que armazenam os dados puxados da API
struct Coin: Identifiable, Decodable {
    var id: String?
    var name: String?
    var symbol: String?
    var rank: Int?
    var isFavorite: Bool?
  // variavel para teste
 //   var error: String
    var description: String?
    var tags: [Tags]?
    var team: [Team]?
}
