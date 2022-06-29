//
//  SecurityView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct SecurityView: View {
    // verifica se eh um campo security
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image("Locker")
                .frame(width: 18, height: 18)
            VStack{
            if isSecureField {
                SecureField("Senha", text: $text)
            } else {
                TextField(text, text: $text)
            }
          }
        .font(Font.custom("Poppins-Regular", size: 12))
        Image(isSecureField ? "eye.slash": "Eye")// trocar imagem figma
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
      }
    }
    
    struct SecurityView_Previews: PreviewProvider {
        static var previews: some View {
            SecurityView(text: .constant("valor"))
        }
    }
