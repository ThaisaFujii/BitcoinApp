//
//  AccountView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var accountvm = AccountVM()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Text("Criar Conta")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.bottom, 82)
                HStack {
                    Image("UserIcon")
                        .frame(width: 18, height: 18)
                    TextField("Login", text: $accountvm.login)
                        .foregroundColor(Color("TextAccount"))
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                .modifier(AccountStyle())
                .padding(.bottom,20)
                
                HStack {
                    Image("UserIcon")
                        .foregroundColor(Color("TextAccount"))
                        .frame(width: 18, height: 18)
                    TextField("CPF", text: $accountvm.digitoCPF)
                        .foregroundColor(Color("TextAccount"))
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                .modifier(AccountStyle())
                .padding(.bottom, 90)
                
                VStack(spacing: 20){
                    SecurityView(text: $accountvm.senha)
                        .modifier(SecurityViewStyle())
                    SecurityView(text: $accountvm.confirmSenha)
                        .modifier(SecurityViewStyle())
                        .padding(.bottom, 58)
                    
                    //trocar para voltar a tela
                    NavigationLink(destination: LoginView(), isActive: $accountvm.verified){}
                    Button(action: {
                        accountvm.Regex()
                    }, label: {
                        Text("Acessar")
                            .modifier(ButtonStyle()) // radius = blur
                    })
                    .alert(isPresented:$accountvm.showingAlert) {
                        Alert(
                            title: Text("As informações não são válidas."),
                            message: Text("Por favor colocar as informacoes corretas")
                        )
                    }
                }
            }
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
