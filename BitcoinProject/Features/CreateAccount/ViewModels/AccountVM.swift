//
//  AccountVM.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/27/22.
//

import Foundation

class AccountVM: ObservableObject {
    @Published var login:String = ""
    @Published var digitoCPF: String = ""
    @Published var senha: String = ""
    @Published var confirmSenha: String = ""
    @Published var showingAlert = false
    @Published var verified = false
    
    func validate(text: String, with regex: String) -> Bool {
        // Create the regex
        guard let gRegex = try? NSRegularExpression(pattern: regex) else {
            return false
        }
        // Create the range
        let range = NSRange(location: 0, length: text.utf16.count)
        // Perform the test
        if gRegex.firstMatch(in: text, options: [], range: range) != nil {
            return true
        }
        return false
    }
    
    func Regex() {
        // desacoplar a logica da tela
        if validate(text: digitoCPF, with:
                        #"^\(?\d{3}\)?[.]?\d{3}[.]?\d{3}[-]?\d{2}$"#) && validate(text: login, with: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#){
            verified = true
        } else {
            showingAlert = true
        }
    }
}
