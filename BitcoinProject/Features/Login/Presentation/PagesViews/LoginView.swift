//
//  LoginView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginview = LoginVM()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("login")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
                Spacer()
                HStack {
                    Image("UserIcon")
                        .frame(width: 18, height: 18)
                    TextField("Login", text: $loginview.login)
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                    .modifier(ConfStyle())
                    .padding(.bottom, 32)
                SecurityView(text: $loginview.password)
                    .modifier(ConfStyle())
                    .padding(.bottom, 72)

                NavigationLink(destination: BemVindoView(), isActive: $loginview.verified){} //criar navigation vazio
                Button(action: {
                    loginview.isCredentialValid()
                }, label: {
                    Text("Acessar")
                        .modifier(ButtonStyle()) // radius = blur
                })
                .padding(.bottom, 42)
                .alert(isPresented:$loginview.showingAlert) {
                    Alert(
                        title: Text("As informações não são válidas."),
                        message: Text("Por favor colocar o login e a senha")
                    )
                }
                NavigationLink(destination: AccountView()) {
                    Text("Criar Nova Conta")
                        .foregroundColor(Color("blue"))
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .underline()
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 42)
        }
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
