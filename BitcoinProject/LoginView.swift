//
//  LoginView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct LoginView: View {
    @State private var login:String = "" //encapsular
    @State private var password:String = ""
    @State private var showingAlert = false
    @State var verified = false
    // criar os booleans para navigationlink
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
                HStack{
                    Image("UserIcon")
                        .frame(width: 18, height: 18)
                    TextField("Login", text: $login)
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                    .modifier(ConfStyle())
                    .padding(.bottom, 32)
                SecurityView(text: $password)
                    .modifier(ConfStyle())
                    .padding(.bottom, 72)

                NavigationLink(destination: BemVindoView(), isActive: $verified){} //criar navigation vazio
                Button(action: {
                    isCredentialValid()
                }, label: {
                    Text("Acessar")
                        .modifier(ButtonStyle()) // radius = blur
                })
                .padding(.bottom, 42)
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("As informações não são válidas."),
                        message: Text("Por favor colocar o login e a senha")
                    )
                }
                NavigationLink(destination: AccountView()){
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
    //app deve exibir um alerta dizendo que as informações não são válidas.
    func isCredentialValid() {
        if login == "thaisa@performait.com" && password == "Thais@2022" {
            verified = true
        } else {
            showingAlert = true
        }
    }
}

struct ConfStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 16)
            .padding(.horizontal, 18)
            .background(Color("textfield"))
            .cornerRadius(14)
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-Bold", size: 16))
            .foregroundColor(.white)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            .background(Color("purple"))
            .cornerRadius(99)
            .shadow(color: Color("purple").opacity(0.3), radius: 10, y: CGFloat(10))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
