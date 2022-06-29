//
//  AppStyles.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/27/22.
//

import Foundation
import SwiftUI


// estrutura de estilo para os cards
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-Medium", size: 16))
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color("backgroundCard"))
            .cornerRadius(14)
            .padding(.vertical, 7.5)
            .padding(.horizontal, 50)
            .shadow(color: Color("shadowCard").opacity(0.07), radius: 20, y: CGFloat(10))
        
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

struct AccountStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-Medium", size: 16))
            .padding()
            .background(Color("textfield"))
            .cornerRadius(14)
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

struct SecurityViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("TextAccount"))
            .font(Font.custom("Poppins-Regular", size: 12))
            .modifier(AccountStyle())
    }
}

struct FilterStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(Font.custom("Poppins-Bold", size: 16))
            .padding(18)
            .background(Color("orange"))// filtro
            .cornerRadius(16)
            .padding(.horizontal, 50)
            .padding(.bottom, 40)
    }
}

// estrutura de estilo para o conteudo a mostra
struct DetailViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-Medium", size: 16))
            .frame(maxWidth: .infinity)
            .background(Color("backgroundCard"))
            .cornerRadius(16)
            .shadow(color: Color("shadowCard").opacity(0.07), radius: 20, y: CGFloat(10))
    }
}
