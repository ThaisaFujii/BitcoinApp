//
//  LoginVM.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/24/22.
//

import Foundation

class LoginVM: ObservableObject {
    @Published var login:String = "" //encapsular
    @Published var password:String = ""
    @Published var showingAlert = false
    @Published var verified = false
    // criar os booleans para navigationlink
    
    //app deve exibir um alerta dizendo que as informações não são válidas.
    func isCredentialValid() {
        if login == "thaisa@performait.com" && password == "Thais@2022" {
            verified = true
        } else {
            showingAlert = true
        }
    }
}
