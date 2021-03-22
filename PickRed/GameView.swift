//
//  GameView.swift
//  PickRed
//
//  Created by User15 on 2021/3/10.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameObject: GameObject
    @State private var isRotated = false
    var body: some View {
        VStack{
            PlayerCardsView(cards: gameObject.players[2].cards, playerNum: 1, direction: 1)
            .offset(y: 10)
            Spacer()
            
            HStack{
                PlayerCardsView(cards: gameObject.players[1].cards, playerNum: 1, direction: 0)
                    .offset(x: 20)
                Spacer()
                
                VStack{
                    Text("剩下：\(52 - gameObject.topCardIndex - 1)張")
                    /*
                     Image("cardback")
                     .resizable()
                     .frame(width: 50, height: 75)
                     .rotationEffect(Angle.degrees(isRotated ? 90 : 0))
                     .animation(.easeIn)
                     */
                    PlayerCardsView(cards: gameObject.tableCards, playerNum: 5, direction: 1)
                }
                //.offset(y: -50)
                
                Spacer()
                PlayerCardsView(cards: gameObject.players[3].cards, playerNum: 1, direction: 0)
                    .offset(x: -50)
            }
            Spacer()
            PlayerCardsView(cards: gameObject.players[0].cards, playerNum: 0, direction: 1)
                .offset(y: -10)
        }
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .opacity(0.8)
        )
        .ignoresSafeArea()
        .onAppear{
            isRotated = true
        }
        
        
        
    }
    
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

