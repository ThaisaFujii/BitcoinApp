//
//  BemVindoView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.
//

import SwiftUI
import Alamofire

// estruturas que armazenam os dados puxados da API
struct Team: Hashable, Decodable {
    var id: String?
    var name: String?
    var position: String?
}

struct Tags: Hashable, Identifiable, Decodable {
    var id: String?
    var name: String?
}

struct Coin: Identifiable, Decodable {
    var id: String?
    var name: String?
    var symbol: String?
    var rank: Int?
    var isFavorite: Bool?
  // variavel para teste
 //   var error: String
    var description: String?
    var tags: [Tags]?
    var team: [Team]?
}


struct BemVindoView: View {
    @State private var chooseBitcoin: Int? // variavel para armazenar a posicao do Item da coinList
    @State private var showFavorite = false // variavel para verificar se o botao de favoritos foi acionado ou nao
    @State private var showingAlert = false // variavel para alertar o usuario se deseja logout do app
    @State private var showingLogout = false // variavel para ativar a mudanca de view e realizar o logout do app
    @State private var novaTela = false // variavel para ativar a navigation view e mudar a tela de BemVindo para DetailView
    @State private var coinList: [Coin] = [] // variavel recebe os items da API
    @State private var isLoading = true // variavel ativa o loading na tela enquanto nao detecta dados da API
    
    
    // funcao pega dados da API e atribui 11 items a coinList
    func getCoinList() {
        AF.request("https://api.coinpaprika.com/v1/coins", method: .get).responseDecodable(of: [Coin].self, decoder: JSONDecoder()){ response in // callback
            isLoading = false
            switch response.result {
            case .success(let data):
                coinList = Array(data[0...10])
            case .failure(let error):
                coinList = []
                print(error)
            }
        }
    }
    
    // variavel para os botoes que filtra favoritos de todos os items
    var getListItems: [Coin] {
    //        showFavorite ? listBitcoin.filter {$0.isFavorite == true} : listBitcoin
    // filtrar se o coinList veio com dados, caso contrario recebe lista vazia
        coinList.filter { listitem in
            (!showFavorite || listitem.isFavorite == true)
        }
    }
    
    var body: some View {
        NavigationView {
            // verificacao se os dados do backend vieram, se nao vieram ira aparecer loading pro usuario
            if isLoading == true {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                // chama a API para poder usar o dados na tela
                .onAppear{
                    getCoinList()
                }
                // esconder o espacamento do navigationview na tela de loading
                .navigationBarHidden(true)
                .navigationBarTitle("", displayMode: .inline)
            } else if coinList.isEmpty == false { //verifica se a lista nao for vazia e mostra os dados
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
                                    showingAlert = true
                                }, label: {
                                    Image("Logout")
                                    
                                })
                                // destino e confirmacao ao usuario sobre sair do app
                                NavigationLink(destination: LoginView(), isActive: $showingLogout){}
                                    .confirmationDialog("Tem certeza que deseja encerrar a sessao?", isPresented: $showingAlert, titleVisibility: .visible ){
                                        
                                        Button("Sair"){ showingLogout = true }}
                            }
                            .padding()
            // parte que mostra todos os items da coinList com o destino para o DetailView
           NavigationLink(destination: DetailView(bitcoinDetail: $coinList[chooseBitcoin ?? 0]), isActive: $novaTela){}
                            ForEach(getListItems, id: \.id) { listItem in
                                Button(action: {
                                    let index = coinList.firstIndex(where: {$0.id == listItem.id})
                                    // index eh nulo?
                                    if let index = index {
                                        chooseBitcoin = index
                                        novaTela = true
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
                                            let index = coinList.firstIndex(where: {$0.id == listItem.id})
                                            // configurar o estado da variavel boolean como false para poder favoritar e desfavoritar
                                            if let index = index {
                                                if coinList[index].isFavorite == nil {
                                                    coinList[index].isFavorite = true
                                                } else {
                                                    coinList[index].isFavorite?.toggle()
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
                            .opacity(showFavorite == true ? 0.5 : 1.0)
                            .onTapGesture{
                                showFavorite = false
                            }
                        Spacer()
                        Text("Favoritos")
                            .opacity(showFavorite == false ? 0.5 : 1.0)
                            .onTapGesture{
                                showFavorite = true
                            }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Bold", size: 16))
                    .padding(18)
                    .background(Color("orange"))// filtro
                    .cornerRadius(16)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 40)
                    
                }
            } else {
                // mensagem amigavel ao usuario para carregar a lista em caso de algum erro
                VStack {
                        Image("error")
                        Text("Ocorreu um problema! Nao foi possivel carregar as informacoes.")
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 32)
                        Text("Tentar Novamente").onTapGesture{isLoading = true}
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

struct BemVindoView_Previews: PreviewProvider {
    static var previews: some View {
        BemVindoView()
    }
}
