//
//  GameOverView.swift
//  PickRed
//
//  Created by Chase on 2021/3/22.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        ZStack{
            Image("sadImage")
                .resizable()
                .frame(width: 150, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .offset(x: -100)
            VStack{
                Text("Game Over")
                Text("你沒錢了...")
            }
            .offset(x: -100)
        }
        .background(Color(red: 254/255, green: 196/255, blue: 1/255))
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
