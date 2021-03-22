//
//  ResultRow.swift
//  PickRed
//
//  Created by Chase on 2021/3/21.
//

import SwiftUI

struct ResultRow: View {
    var playerNum: Int
    var point: Int
    var coin: Int
    var result: Int
    var body: some View {
        HStack{
            if(playerNum==0){
                Text("玩家")
                    .frame(width: 125, height: 30, alignment: .center)
            }
            else{
                Text("Computer\(playerNum)")
                    .frame(width: 125, height: 30, alignment: .center)
            }
            Text("\(point)")
                .frame(width: 125, height: 30, alignment: .center)
            Text("\(coin)")
                .frame(width: 125, height: 30, alignment: .center)
            if(result<0){
                Text("\(result)")
                    .frame(width: 125, height: 30, alignment: .center)
            }
            else{
                Text("+\(result)")
                    .frame(width: 125, height: 30, alignment: .center)
            }
        }
        
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        ResultRow(playerNum: 0, point: 1000, coin: 1000, result: 100)
    }
}
