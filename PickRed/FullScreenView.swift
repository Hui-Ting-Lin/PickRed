//
//  FullScreenView.swift
//  PickRed
//
//  Created by User15 on 2021/3/17.
//

import SwiftUI

struct FullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameObject: GameObject
    
    var body: some View {
        VStack{
            if(gameObject.gameOver){
                VStack{
                    Text("Game Over!!")
                    Text("有玩家沒錢了")
                }
            }
            VStack{
                ForEach(0..<gameObject.players.count){ (index) in
                    HStack{
                        Text("player\(index)")
                        Text("\(gameObject.players[index].point)")
                        Text("\(gameObject.players[index].coin)")
                        if(gameObject.players[index].result<0){
                            Text("\(gameObject.players[index].result)")
                        }
                        else{
                            Text("+\(gameObject.players[index].result)")
                        }
                        
                    }
                }
            }
            HStack{
                Button("下一局"){
                    presentationMode.wrappedValue.dismiss()
                    makeCards()
                    makePlayers()
                    gameObject.cardDeck.shuffle()
                    dealCards()
                }
                Button("回到主畫面"){
                    gameObject.dealing = false
                    gameObject.isHome = true
                    presentationMode.wrappedValue.dismiss()
                }
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
        var coins = [0, 0, 0, 0]
        for index in 0...3{
            coins[index] = gameObject.players[index].coin
        }
        gameObject.players = []
        for index in 0...3{
            gameObject.players.append(Player(cards: [], point: 0, eatCard: [], coin: coins[index], result: 0))
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

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenView()
    }
}
