//
//  BemVindoVM.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/24/22.
//

import Foundation
import Alamofire

class BemVindoVM: ObservableObject {
    @Published var chooseBitcoin: Int? // variavel para armazenar a posicao do Item da coinList
    @Published var showFavorite = false // variavel para verificar se o botao de favoritos foi acionado ou nao
    @Published var showingAlert = false // variavel para alertar o usuario se deseja logout do app
    @Published var showingLogout = false // variavel para ativar a mudanca de view e realizar o logout do app
    @Published var novaTela = false // variavel para ativar a navigation view e mudar a tela de BemVindo para DetailView
    @Published var coinList: [Coin] = [] // variavel recebe os items da API
    @Published var isLoading = true // variavel ativa o loading na tela enquanto nao detecta dados da API
    
    
    // funcao pega dados da API e atribui 11 items a coinList
    func getCoinList() {
        AF.request("\(Constants.API)/coins", method: .get).responseDecodable(of: [Coin].self, decoder: JSONDecoder()){ response in // callback
            self.isLoading = false
            switch response.result {
            case .success(let data):
                self.coinList = Array(data[0...10])
            case .failure(let error):
                self.coinList = []
                print(error)
            }
        }
    }
    // variavel para os botoes que filtra favoritos de todos os items
    var getListItems: [Coin] {
        //        showFavorite ? listBitcoin.filter {$0.isFavorite == true} : listBitcoin
        // filtrar se o coinList veio com dados, caso contrario recebe lista vazia
        coinList.filter { listitem in
            (!showFavorite || listitem.isFavorite == true)
        }
    }
}
