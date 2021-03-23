//
//  HomeView.swift
//  PickRed
//
//  Created by User15 on 2021/3/10.
//

import SwiftUI
import AVFoundation

class GameObject: ObservableObject{
    @Published var cardDeck: [Card] = []
    @Published var players: [Player] = []
    @Published var topCardIndex: Int = 0
    @Published var tableCards: [Card] = []
    @Published var bankerNum: Int = 0
    @Published var turn: Int = Int.random(in: 0...3)
    //@Published var turn: Int = 0
    @Published var isHome = true
    @Published var gameOver = false
    @Published var dealing = false
    @Published var showCard: [Bool] = [true]
    @Published var loserIsPlayer: Bool = false
    @Published var cardBack = "redBack"
    @Published var isChoosingCard = false
}


struct HomeView: View {
    @StateObject var gameObject = GameObject()
    @State var looper: AVPlayerLooper?
    var body: some View {
        ZStack{
            if(gameObject.isHome){
                VStack{
                    Text("撿紅點")
                        .foregroundColor(Color.black)
                        .font(.custom("jf-openhuninn-1.1", size: 50))
                        .padding()
                    HStack{
                        Button {
                            gameObject.isHome = false
                            gameObject.dealing = true
                        } label: {
                            Text("開始遊戲")
                                .font(.custom("jf-openhuninn-1.1", size: 25))
                        }
                        .onAppear{
                            makeCards()
                            makePlayers()
                            gameObject.cardDeck.shuffle()
                            dealCards()
                            for _ in 0..<52{
                                gameObject.showCard.append(true)
                            }
                        }
                        .padding()
                        
                        Link("規則說明", destination: URL(string: "https://dylanwan.pixnet.net/blog/post/18071031")!)
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                            .padding()
                        
                        Button {
                            gameObject.isHome = false
                            gameObject.isChoosingCard = true
                        } label: {
                            Text("選擇牌背")
                                .font(.custom("jf-openhuninn-1.1", size: 25))
                        }
                        .padding()
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center)
                .background(
                    Image("mainImage")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                )
                .ignoresSafeArea(.all)
            }
            else{
                if(gameObject.dealing){
                    DealAnimationView()
                        .environmentObject(gameObject)
                }
                else if(gameObject.isChoosingCard){
                    ChooseCardView().environmentObject(gameObject)
                }
                else{
                    GameView()
                        .environmentObject(gameObject)
                }
                
            }
        }
        .onAppear{
            let player = AVQueuePlayer()
            let fileUrl = Bundle.main.url(forResource: "cuteMusic", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: fileUrl)
            self.looper = AVPlayerLooper(player: player, templateItem: playerItem)
            player.play()
        }
        
    }
    
    func makeCards(){
        let suits = ["clubs", "diamond", "heart", "spade"]//梅花 方塊 紅心 黑桃
        gameObject.cardDeck = []
        for suitIndex in 0...3{
            for num in 1...13{
                if(suitIndex==0||suitIndex==3){
                    gameObject.cardDeck.append(Card(suit: suits[suitIndex], color: "black", value: num))
                }//黑
                else{
                    gameObject.cardDeck.append(Card(suit: suits[suitIndex], color: "red", value: num))
                }//紅
            }
        }
    }
    
    func makePlayers(){
        gameObject.players = []
        for _ in 0...3{
            gameObject.players.append(Player(cards: [], point: 0, eatCard: [], coin: 1000, result: 0))
        }
    }
    
    
    func dealCards(){
        gameObject.topCardIndex = 0
        for cardIndex in 0...5{
            for playerIndex in 0...3{
                gameObject.topCardIndex = 4*cardIndex+playerIndex
                gameObject.players[playerIndex].cards.append(gameObject.cardDeck[gameObject.topCardIndex])
                
            }
        }
        gameObject.tableCards = []
        for _ in 0...3{
            gameObject.topCardIndex+=1
            gameObject.tableCards.append(gameObject.cardDeck[gameObject.topCardIndex])
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
