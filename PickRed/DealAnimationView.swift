//
//  DealAnimationView.swift
//  PickRed
//
//  Created by Chase on 2021/3/18.
//

import SwiftUI

struct DealAnimationView: View {
    @EnvironmentObject var gameObject: GameObject
    @State private var currentDate = Date()
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader{ geometry in
            /*Image("Image")
             .resizable()
             .scaledToFill()
             .opacity(0.8)*/
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    ZStack{
                        ForEach(0..<52, id: \.self){ index in
                            if(index%4==0){
                                if(gameObject.showCard[index]){
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .transition(.bottomTransition)
                                }
                                else{
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .hidden()
                                }
                            }
                            else if(index%4==1){
                                if(gameObject.showCard[index]){
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .transition(.leftTransition)
                                }
                                else{
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .hidden()
                                }
                            }
                            else if(index%4==2){
                                if(gameObject.showCard[index]){
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .transition(.topTransition)
                                }
                                else{
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .hidden()
                                }
                            }
                            else if(index%4==3){
                                if(gameObject.showCard[index]){
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .transition(.rightTransition)
                                }
                                else{
                                    Image(gameObject.cardBack)
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .hidden()
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8)
            )
            
            .onReceive(timer){ input in
                withAnimation{
                    let timeInterval = input.timeIntervalSince1970 - currentDate.timeIntervalSince1970
                    gameObject.showCard[Int((timeInterval-1)*2)] = false
                    if(Int((timeInterval-1)*2)>=23){
                        timer.upstream.connect().cancel()
                        gameObject.dealing = false
                    }
                }
            }
            .onAppear{
                gameObject.turn =  Int.random(in: 0...3)
            }
            .ignoresSafeArea(.all)
            
            
        }
    }
}

extension AnyTransition{
    static var rightTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: UIScreen.main.bounds.size.width/2-100, y: 0)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var leftTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: -UIScreen.main.bounds.size.width/2+100, y: 0)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var topTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: 0, y: -UIScreen.main.bounds.size.height/2+50)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var bottomTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: 0, y: UIScreen.main.bounds.size.height/2-50)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}

struct DealAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        DealAnimationView()
    }
}
