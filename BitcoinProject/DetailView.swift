
//  DetailView.swift
//  BitcoinProject
//
//  Created by Thaisa Fujii on 6/1/22.

/* Detalhes da implementacao -- Testar antes de passar pra outras tasks
 Item 1 - Criar struct para Team OK
 Item 1. - criar as variaveis que faltam na struct Coin, nomear conforme na documentacao OK
 Item 1.1 - deixa-las como opcionais OK
 Item 1.2 - adicionar o protocolo Decorable na struct de Team OK
 Item 2 - criar uma struct para Tag String OK
 Item 3 - alterar o tipo da variavel bitcoinDetail para a nova struct OK
 Item 4 - criar on appear na stack do detailview OK
 Item 4.1 - criar a funcao sem parametros para usar o get na API OK
 Item 4.2 - fazer a requisicao da API "https://api.coinpaprika.com/v1/coins/{id da moeda}" dentro da funcao OK
 Item 4.3 - substituir o id da moeda pelo id da coin escolhida OK
 Item 4.4 - chamar a funcao no onappear OK
 Item 5.2 - Como passar o id do elemento selecionado na navigation view - index posicao OK
 
 - EXTRA -
 navigation hidden OK
 Colocar pra favoritar OK
 Colocar erro OK
 Colocar loader OK
 
 Se nao tiver time ou tag ou descricao colocar "not found" OK
 padding na tag OK
 
 - DESAFIO -
 Fazer com que as informacoes fiquem salvas apos uma vez ja clicadas ... quando passa pra outra view se o usuario clicar novamente nao deve carregar as informacoes pela segunda vez.
 */

import SwiftUI
import Alamofire

struct DetailView: View {
    @Binding var bitcoinDetail: Coin // variavel que realiza coneccao de duas vias entre o dado/item que a propriedade recebe
    @State private var isLoading = true
    @State private var isCompleted = false // variavel que ativa a view quando os dados da API chega no sistema
    
    
    // funcao que pega o item da coinList da API e mostra somente os detalhes do item selecionado
    func getCoinItem(){
        // injetar erro no coins
        AF.request("https://api.coinpaprika.com/v1/coins/\(bitcoinDetail.id ?? "")", method: .get).responseDecodable(of: Coin.self, decoder: JSONDecoder()){ response in // callback
            isLoading = false
            switch response.result {
            case .success(let data):
                isCompleted = true
                bitcoinDetail.tags = data.tags
                bitcoinDetail.team = data.team
                bitcoinDetail.description = data.description
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            // verificacao se os dados do backend vieram, se nao vieram ira aparecer loading pro usuario
            if isLoading == true {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                // ativa a funcao que puxa dados da API para poder mostrar na tela
                .onAppear {
                    getCoinItem()
                }
            } else if isCompleted == true { // verifica se o backend criou os dados para "captura"
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(bitcoinDetail.name ?? "Not Found")
                        Spacer()
                        // botao favoritos com opcao de favoritar ou desfavoritar na tela de Detail
                        Image(bitcoinDetail.isFavorite == true ? "redHeart" : "heart").onTapGesture {
                            if bitcoinDetail.isFavorite == nil {
                                bitcoinDetail.isFavorite = true
                            } else {
                                bitcoinDetail.isFavorite?.toggle()
                                // validacao
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(Font.custom("Poppins-Bold", size: 20))
                    .padding(.leading, 24)
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Descrição")
                            .padding()
                        //description pode ser nulo ou vazio, se verdadeiro "not found"
                        // verificacao se veio dado, se o dado esta vazio ou se eh nulo/sem dado em ternario
                        Text(bitcoinDetail.description?.isEmpty == false ? bitcoinDetail.description ?? "Not Found" : "Not Found")
                            .padding()
                            .font(Font.custom("Poppins-Regular", size: 16))
                    }
                    // nunca usar .infinity com width ou soh height
                    .frame(maxWidth: .infinity)
                    .modifier(Style())
                    .padding(10)
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Tags")
                            .padding(.bottom, 22)
                            .padding(.leading, 10)
                        // colocar scroll horiozontal para as tags
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                // pode vir lista de tags vazio ou nulo
                                if bitcoinDetail.tags?.isEmpty == false {
                                    // loop para poder pegar cada tag que veio na lista
                                    ForEach(bitcoinDetail.tags!, id: \.self) { tag in
                                        //tratamento se veio conteudo na tag
                                        if tag.name?.isEmpty == false {
                                            Text(tag.name ?? "Not Found")
                                                .padding(10)
                                                .foregroundColor(.white)
                                                .padding(.horizontal,30)
                                                .background(Color("blue"))
                                                .cornerRadius(20)
                                                .padding(.bottom, 25)
                                                .font(Font.custom("Poppins-Bold", size: 14))
                                        } else {
                                            // caso na venha nada na propriedade nome da lista nenhuma
                                            Text("Not Found")
                                        }
                                    }
                                } else {
                                    // caso na venha lista nenhuma
                                    Text("Not Found")
                                }
                            }
                        }
                        .padding(20)
                        .modifier(Style())
                        .padding(14)
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading) {
                            Text("Time")
                                .padding(.top, 8)
                                .padding(.bottom, 10)
                            // verificacao de dados da lista team
                            if bitcoinDetail.team?.isEmpty == false {
                                ForEach(bitcoinDetail.team ?? [], id: \.self) { time in
                                    // verificacao das propriedades da lista em formato ternario
                                    Text(time.name?.isEmpty == false ? time.name ?? "Not Found" : "Not Found")
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .padding(.bottom, 7)
                                    // verificacao das propriedades da lista em formato ternario
                                    Text(time.position?.isEmpty == false ? time.position ?? "Not Found" : "Not Found")
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .padding(.bottom, 7)
                                }
                            } else {
                                // lista vazia
                                Text("Not Found")
                            }
                        }
                        
                        .modifier(Style())
                        .padding(10)
                    }
                    .onAppear{
                        getCoinItem()
                    }
                }
            }else {
                // view de erro para quando nao foi identificado nenhum dado vindo do backend
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
                .padding(.top, 150)
            }
        }
    }
}

// estrutura de estilo para o conteudo a mostra
struct Style: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins-Medium", size: 16))
            .frame(maxWidth: .infinity)
            .background(Color("backgroundCard"))
            .cornerRadius(16)
            .shadow(color: Color("shadowCard").opacity(0.07), radius: 20, y: CGFloat(10))
    }
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(bitcoinDetail: .constant(Coin()))
    }
}
