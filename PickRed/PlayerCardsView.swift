//
//  PlayerCardsView.swift
//  PickRed
//
//  Created by Chase on 2021/3/14.
//

import SwiftUI

struct PlayerCardsView: View {
    @EnvironmentObject var gameObject: GameObject
    @State private var selectCard: Card = Card(suit: "heart", color: "red", value: 0)
    @State private var pointTable: [Int] = [20, 2, 3, 4, 5, 6, 7, 8, 10, 10, 10, 10, 10]
    @State private var isPresented = false
    var cards: [Card]
    var playerNum: Int//0: player, 1, 2, 3: computer
    var direction: Int//0: vertical, 1: horizontal
    
    var body: some View {
        ZStack{
            ForEach(0..<cards.count, id: \.self){ (index) in
                if(direction==1 && (playerNum==0 || playerNum==5) ){
                    Button {
                        if(gameObject.turn==0 && playerNum==0){
                            selectCard = gameObject.players[0].cards.remove(at: index)
                            judgeTable(isFirst: true, count: gameObject.tableCards.count)
                            gameObject.turn+=1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                computerTurns()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    computerTurns()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        computerTurns()
                                    }
                                }
                            }
                            
                        }
                    } label: {
                        Image("\(cards[index].suit)\(cards[index].value)")
                            .resizable()
                            .transition(.topTransition)
                    }
                    .frame(width: 50, height: 75)
                    .offset(x: CGFloat(index * 20) - 50)
                    
                }//player
                else if (direction==1){
                    Image(gameObject.cardBack)
                        .resizable()
                        .frame(width: 50, height: 75)
                        .offset(x: CGFloat(index * 20) - 50)
                }
                else{
                    Image(gameObject.cardBack)
                        .resizable()
                        .frame(width: 50, height: 75)
                        .rotationEffect(.degrees(90))
                        .offset(y: CGFloat(index * 20) - 50)
                        .ignoresSafeArea()
                }//直的
                
            }
            
        }
        .fullScreenCover(isPresented: $isPresented, content: FullScreenView.init)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                computerTurns()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    computerTurns()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        computerTurns()
                    }
                }
                
            }
        }
    }
    
    
    func eatCard(tableCard: Card, selectCard: Card, cardIndex: Int, isFirst: Bool, eatRed: Bool){
        gameObject.players[gameObject.turn].eatCard.append(tableCard)
        gameObject.players[gameObject.turn].eatCard.append(selectCard)
        if(eatRed){
            gameObject.players[gameObject.turn].point+=pointTable[tableCard.value-1]
        }
        if(selectCard.color=="red"){
            gameObject.players[gameObject.turn].point+=pointTable[selectCard.value-1]
        }
        gameObject.tableCards.remove(at: cardIndex)
        if(!isFirst){
            gameObject.tableCards.remove(at: gameObject.tableCards.count-1)
        }
        print("player\(gameObject.turn) 吃了牌面的\(tableCard.suit)\(tableCard.value)")
        
        if(isFirst){
            getTopCard()
        }
    }
    
    func judgeTable(isFirst: Bool, count: Int){
        if(isFirst) {print("player\(gameObject.turn) 出了\(selectCard.suit)\(selectCard.value)")}
        for index in 0..<count{
            if(gameObject.tableCards[index].color=="red"){
                if(gameObject.tableCards[index].value+selectCard.value==10){
                    eatCard(tableCard: gameObject.tableCards[index], selectCard: selectCard, cardIndex: index, isFirst: isFirst, eatRed: true)
                    return
                }
                else if(selectCard.value>=10 && gameObject.tableCards[index].value==selectCard.value){
                    eatCard(tableCard: gameObject.tableCards[index], selectCard: selectCard, cardIndex: index, isFirst: isFirst, eatRed: true)
                    return
                }
            }//優先吃紅的
            else{
                if(gameObject.tableCards[index].value+selectCard.value==10){
                    eatCard(tableCard: gameObject.tableCards[index], selectCard: selectCard, cardIndex: index, isFirst: isFirst, eatRed: false)
                    return
                }
                else if(selectCard.value>=10 && gameObject.tableCards[index].value==selectCard.value){
                    eatCard(tableCard: gameObject.tableCards[index], selectCard: selectCard, cardIndex: index, isFirst: isFirst, eatRed: false)
                    return
                }
            }//再吃黑的
        }
        
        //沒得吃
        if(isFirst){
            print("player\(gameObject.turn) 的 \(selectCard.suit)\(selectCard.value)放到桌上")
            gameObject.tableCards.append(selectCard)
            getTopCard()
        }//再翻一張
    }
    
    func getTopCard(){
        print("player\(gameObject.turn) 翻牌")
        gameObject.topCardIndex+=1
        print("player\(gameObject.turn) 翻到 \(gameObject.cardDeck[gameObject.topCardIndex].suit) \(gameObject.cardDeck[gameObject.topCardIndex].value)")
        gameObject.tableCards.append(gameObject.cardDeck[gameObject.topCardIndex])
        selectCard = gameObject.cardDeck[gameObject.topCardIndex]
        print("剩下\(52-gameObject.topCardIndex-1)張")
        judgeTable(isFirst: false, count: gameObject.tableCards.count-1)
    }//翻牌
    
    //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
    
    func computerTurns(){
        
        if(gameObject.turn != 0 && gameObject.topCardIndex < 51){
            
            let selectCardIndex = Int.random(in: 0..<gameObject.players[gameObject.turn].cards.count)
            
            selectCard = gameObject.players[gameObject.turn].cards.remove(at: selectCardIndex)
            judgeTable(isFirst: true, count: gameObject.tableCards.count)
            
            gameObject.turn=(gameObject.turn+1)%gameObject.players.count
        }
        
        if(gameObject.topCardIndex==51){
            gameObject.topCardIndex=52
            endGame()
            isPresented = true
        }
    }
    
    func endGame(){
        var points = [0, 0, 0, 0]
        var maxPoint = 0
        var maxIndex = 0
        for index in 0..<4{
            points[index] = gameObject.players[index].point
        }
        maxPoint = points.max()!
        
        for index in 0..<4{
            if(gameObject.players[index].point==maxPoint){
                maxIndex = index
            }
            gameObject.players[index].result = (maxPoint - gameObject.players[index].point) * (-10)
        }
        
        for index in 0..<4{
            if(index != maxIndex){
                gameObject.players[index].coin = gameObject.players[index].coin+gameObject.players[index].result >= 0 ? gameObject.players[index].coin+gameObject.players[index].result : 0
                gameObject.players[maxIndex].result-=gameObject.players[index].result
            }
            
            if(gameObject.players[index].coin == 0){
                if(gameObject.players[0].coin == 0){
                    gameObject.loserIsPlayer = true
                }
                else{
                    gameObject.loserIsPlayer = false
                }
                gameObject.gameOver = true
            }
            
        }
        gameObject.players[maxIndex].coin+=gameObject.players[maxIndex].result
        
        
    }
    
}
