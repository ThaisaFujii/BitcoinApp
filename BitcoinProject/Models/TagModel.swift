//
//  TagModel.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/27/22.
//

import Foundation
// estruturas que armazenam os dados puxados da API

struct Tags: Hashable, Identifiable, Decodable {
    var id: String?
    var name: String?
}
