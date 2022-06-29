//
//  DetailVM.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/27/22.
//

import Foundation
import Alamofire

class DetailVM: ObservableObject {
    @Published var isLoading = true
    @Published var isCompleted = false // variavel que ativa a view quando os dados da API chega no sistema
    
    // funcao que pega o item da coinList da API e mostra somente os detalhes do item selecionado
    func getCoinItem(id:String, callback: @escaping (Coin) -> Void){
        // injetar erro no coins p teste
        AF.request("\(Constants.API)coins/\(id)", method: .get).responseDecodable(of: Coin.self, decoder: JSONDecoder()){ response in // callback
            self.isLoading = false
            switch response.result {
            case .success(let data):
                self.isCompleted = true
                callback(data)
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }

}
