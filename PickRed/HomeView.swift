//
//  HomeView.swift
//  PickRed
//
//  Created by User15 on 2021/3/10.
//

import SwiftUI

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
}


struct HomeView: View {
    @StateObject var gameObject = GameObject()
    
    var body: some View {
        if(gameObject.isHome){
            Text("start")
                .onAppear{
                    makeCards()
                    makePlayers()
                    gameObject.cardDeck.shuffle()
                    dealCards()
                }
                .onTapGesture {
                    gameObject.isHome = false
                    gameObject.dealing = true
                }
        }
        else{
            if(gameObject.dealing){
                gameObject.dealing = false
            }
            else{
                GameView()
                    .environmentObject(gameObject)
            }
            
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
