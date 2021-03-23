//
//  ChooseCardView.swift
//  PickRed
//
//  Created by Chase on 2021/3/24.
//

import SwiftUI

struct ChooseCardView: View {
    @EnvironmentObject var gameObject: GameObject
    @State private var backs = ["redBack", "blueBack", "yellowBack"]
    var body: some View {
        ZStack{
            Image("back")
                .resizable()
                .scaledToFill()
                .opacity(0.8)
            VStack{
                Text("選擇卡片背面")
                    .font(.custom("jf-openhuninn-1.1", size: 25))
                    .foregroundColor(Color.black)
                HStack{
                    ForEach(0..<3){ index in
                        Button {
                            gameObject.cardBack = backs[index]
                            gameObject.isChoosingCard = false
                            gameObject.isHome = true
                        } label: {
                            Image(backs[index])
                                .resizable()
                                .frame(width: 80, height: 120)
                        }
                        .padding()
                    }
                    
                }
                
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct ChooseCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCardView()
    }
}
