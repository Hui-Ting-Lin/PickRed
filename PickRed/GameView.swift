//
//  GameView.swift
//  PickRed
//
//  Created by User15 on 2021/3/10.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameObject: GameObject
    
    var body: some View {
        VStack{
            PlayerCardsView(cards: gameObject.players[2].cards, playerNum: 1, direction: 1)
            Spacer()
            HStack{
                PlayerCardsView(cards: gameObject.players[1].cards, playerNum: 1, direction: 0)
                    .padding()
                Spacer()
                
                VStack{
                    Text("剩下：\(52 - gameObject.topCardIndex - 1)張")
                        .padding()
                    PlayerCardsView(cards: gameObject.tableCards, playerNum: 1, direction: 1)
                        .padding()
                }
                
                Spacer()
                PlayerCardsView(cards: gameObject.players[3].cards, playerNum: 1, direction: 0)
                    .padding()
            }
            Spacer()
            PlayerCardsView(cards: gameObject.players[0].cards, playerNum: 0, direction: 1)
        }
        
    }
    
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

