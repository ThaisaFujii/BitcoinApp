//
//  AccountView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct AccountView: View {
    @State private var login:String = ""
    @State private var digitoCPF: String = ""
    @State private var senha: String = ""
    @State private var confirmSenha: String = ""
    @State private var showingAlert = false
    @State var verified = false
    
    var body: some View {
        ScrollView {
            VStack{
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
                TextField("Login", text: $login)
                    .foregroundColor(Color("TextAccount"))
                    .font(Font.custom("Poppins-Regular", size: 12))
            }
            .modifier(AccountStyle())
            .padding(.bottom,20)
            
            HStack {
                Image("UserIcon")
                    .foregroundColor(Color("TextAccount"))
                    .frame(width: 18, height: 18)
                TextField("CPF", text: $digitoCPF)
                    .foregroundColor(Color("TextAccount"))
                    .font(Font.custom("Poppins-Regular", size: 12))
            }
            .modifier(AccountStyle())
            .padding(.bottom, 90)
                
            VStack(spacing: 20){
                SecurityView(text: $senha)
                    .foregroundColor(Color("TextAccount"))
                    .font(Font.custom("Poppins-Regular", size: 12))
                    .modifier(AccountStyle())
                SecurityView(text: $confirmSenha)
                    .foregroundColor(Color("TextAccount"))
                    .font(Font.custom("Poppins-Regular", size: 12))
                    .modifier(AccountStyle())
                    .padding(.bottom, 58)

//                //trocar para voltar a tela
                NavigationLink(destination: LoginView(), isActive: $verified){}
                Button(action: {
                    // desacoplar a logica da tela
                    if validate(text: digitoCPF, with:
                                    #"^\(?\d{3}\)?[.]?\d{3}[.]?\d{3}[-]?\d{2}$"#) && validate(text: login, with: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#){
                        verified = true
                    } else {
                        showingAlert = true
                    }
                    
                }, label: {
                    Text("Acessar")
                        .modifier(ButtonStyle()) // radius = blur
                })
                    .alert(isPresented:$showingAlert) {
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


struct AccountStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .font(Font.custom("Poppins-Medium", size: 16))
            .padding()
            .background(Color("textfield"))
            .cornerRadius(14)
    }
}

struct ButtonStyle2: ViewModifier {
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
