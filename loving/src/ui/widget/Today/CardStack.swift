//
//  CardStack.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct Card {
    let id: Int
    
    let image: String
    let message: String
    
    let partnerName: String
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CardStack: View {
    @State var cardList = [
        Card(id: 1, image: "date", message: "記念日ご飯行こうか", partnerName: "ママ"),
        Card(id: 2, image: "drive", message: "部活乗せてって", partnerName: "パパ"),
        Card(id: 3, image: "movie", message: "進撃の巨人観にいこう", partnerName: "息子ちゃん"),
        Card(id: 4, image: "sports", message: "サッカーしよう", partnerName: "ママ"),
        Card(id: 5, image: "shopping", message: "あれ買ってきて", partnerName: "あいつ")
    ]
    
    private func getCardWidth(_ geometry: GeometryProxy, position: Int) -> CGFloat {
        let offset = CGFloat(cardList.count - 1 - position) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, position: Int) -> CGFloat {
        return CGFloat(cardList.count - 1 - position) * 10
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ForEach(self.cardList, id: \.id) { card in
                        Group {
                            TodayCard(
                                id: card.id,
                                onRemove: { swipeState, id in
                                    print("remove: \(swipeState)")
                                    self.cardList.removeAll {
                                        $0.id == id
                                    }
                                },
                                cardInfo: CardInfo(
                                    image: card.image,
                                    title: "デートしよう",
                                    userImage: "profile_default",
                                    userName: card.partnerName,
                                    content: card.message
                                )
                            )
                                .animation(.spring())
                                .frame(width: self.getCardWidth(geometry, position: self.cardList.firstIndex(of: card) ?? 0), height: 400)
                                .offset(x: 0, y: self.getCardOffset(geometry, position: self.cardList.firstIndex(of: card) ?? 0))
                                
                        }
                    }
                }
            }
        }.padding(Const.Padding.M)
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        CardStack()
    }
}
