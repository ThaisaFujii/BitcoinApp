//
//  BemVindoView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI

struct BemVindoView: View {
    @ObservedObject var bemvindoviewmodel = BemVindoVM()
    
    var body: some View {
        NavigationView {
            // verificacao se os dados do backend vieram, se nao vieram ira aparecer loading pro usuario
            if bemvindoviewmodel.isLoading == true {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                // chama a API para poder usar o dados na tela
                .onAppear {
                    bemvindoviewmodel.getCoinList()
                }
                // esconder o espacamento do navigationview na tela de loading
                .navigationBarHidden(true)
                .navigationBarTitle("", displayMode: .inline)
            } else if bemvindoviewmodel.coinList.isEmpty == false { //verifica se a lista nao for vazia e mostra os dados
                ZStack(alignment: .bottom) {
                    ScrollView {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Bem vindo")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Poppins-Bold", size: 20))
                                    .padding(.leading, 24)
                                Spacer()
                                //botao para sair do app
                                Button(action: {
                                    bemvindoviewmodel.showingAlert = true
                                }, label: {
                                    Image("Logout")
                                    
                                })
                                // destino e confirmacao ao usuario sobre sair do app
                                NavigationLink(destination: LoginView(), isActive: $bemvindoviewmodel.showingLogout){}
                                    .confirmationDialog("Tem certeza que deseja encerrar a sessao?", isPresented: $bemvindoviewmodel.showingAlert, titleVisibility: .visible ){
                                        
                                        Button("Sair"){ bemvindoviewmodel.showingLogout = true }}
                            }
                            .padding()
                            // parte que mostra todos os items da coinList com o destino para o DetailView
                            // DetailView
                            //bitcoinDetail: $bemvindoviewmodel.coinList[bemvindoviewmodel.chooseBitcoin ?? 0]
                            NavigationLink(destination: DetailView(bitcoinDetail: $bemvindoviewmodel.coinList[bemvindoviewmodel.chooseBitcoin ?? 0]), isActive: $bemvindoviewmodel.novaTela){}
                            ForEach(bemvindoviewmodel.getListItems, id: \.id) { listItem in
                                Button(action: {
                                    let index = bemvindoviewmodel.coinList.firstIndex(where: {$0.id == listItem.id})
                                    // index eh nulo?
                                    if let index = index {
                                        bemvindoviewmodel.chooseBitcoin = index
                                        bemvindoviewmodel.novaTela = true
                                    }
                                }) {
                                    HStack {
                                        Text("#\(String(listItem.rank ?? 0)) ")
                                            .font(Font.custom("Poppins-SemiBold", size: 24))
                                            .foregroundColor(Color("blue"))
                                        Text(listItem.name ?? "")
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        Image(listItem.isFavorite == true ? "redHeart" : "heart").onTapGesture {
                                            // encontrar o verdadeiro item da lista pela posicao
                                            let index = bemvindoviewmodel.coinList.firstIndex(where: {$0.id == listItem.id})
                                            // configurar o estado da variavel boolean como false para poder favoritar e desfavoritar
                                            if let index = index {
                                                if bemvindoviewmodel.coinList[index].isFavorite == nil {
                                                    bemvindoviewmodel.coinList[index].isFavorite = true
                                                } else {
                                                    bemvindoviewmodel.coinList[index].isFavorite?.toggle()
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            .modifier(CardStyle())
                        }
                    }
                    // criacao do filtro/botao todos e favorito
                    HStack{
                        Text("Filtrar:")
                            .font(Font.custom("Poppins-Regular", size: 16))
                        Spacer()
                        Text("Todos")
                            .opacity(bemvindoviewmodel.showFavorite == true ? 0.5 : 1.0)
                            .onTapGesture{
                                bemvindoviewmodel.showFavorite = false
                            }
                        Spacer()
                        Text("Favoritos")
                            .opacity(bemvindoviewmodel.showFavorite == false ? 0.5 : 1.0)
                            .onTapGesture{
                                bemvindoviewmodel.showFavorite = true
                            }
                        
                        Spacer()
                    }
                    .modifier(FilterStyle())
                }
            } else {
                // mensagem amigavel ao usuario para carregar a lista em caso de algum erro
                VStack {
                    Image("error")
                    Text("Ocorreu um problema! Nao foi possivel carregar as informacoes.")
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 32)
                    Text("Tentar Novamente").onTapGesture{bemvindoviewmodel.isLoading = true}
                        .modifier(ButtonStyle())
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 42)
            }
        }
        // esconder o espacamento do navigationview na tela de bemvindoview
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct BemVindoView_Previews: PreviewProvider {
    static var previews: some View {
        BemVindoView()
    }
}
