//
//  TodayCardView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct CardInfo {
    let image: String
    let title: String
    let userImage: String
    let userName: String
    let content: String
}

struct TodayCard: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: SwipeStatus = .none
    
    private let cardInfo: CardInfo
    
    private var id: Int
    private var onRemove: (_ status: SwipeStatus, _ id: Int) -> Void
    
    // 50%ドラッグで削除する
    private let removeThresholdPercentage: CGFloat = 0.5
    
    enum SwipeStatus: Int {
        case accept, deny, none
    }
    
    init(id: Int, onRemove: @escaping (_ status: SwipeStatus, _ id: Int) -> Void, cardInfo: CardInfo) {
        self.id = id
        self.onRemove = onRemove
        self.cardInfo = cardInfo
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack {
                    Image(self.cardInfo.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                        .clipped()
                    Text(self.cardInfo.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black, radius: Const.Shadow, x: 0, y: 0)
                        .font(.title)
                }
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(Color.gray)
                        .frame(width: 64, height: 64)
                    VStack(alignment: .leading, spacing: Const.Padding.M) {
                        Text(self.cardInfo.content)
                            .font(.system(size: Const.FontSize.L))
                            .bold()
                        Text(self.cardInfo.userName)
                            .font(.system(size: Const.FontSize.M))
                    }
                }
                .padding(.horizontal, Const.Padding.M)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(Const.CornerRadius)
            .shadow(radius: Const.Shadow)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        
                        let gesturePercentage = self.getGesturePercentage(geometry, from: value)
                        if gesturePercentage >= self.removeThresholdPercentage {
                            self.swipeStatus = .accept
                        } else if (gesturePercentage <= -self.removeThresholdPercentage) {
                            self.swipeStatus = .deny
                        } else {
                            self.swipeStatus = .none
                        }
                    }
                    .onEnded { value in
                        let gesturePercentage = self.getGesturePercentage(geometry, from: value)
                        if abs(gesturePercentage) > self.removeThresholdPercentage {
                            self.onRemove(self.swipeStatus, self.id)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
    
    // geometryの横幅からジェスチャーでどのくらい動かしたか
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
}

struct TodayCard_Previews: PreviewProvider {
    static var previews: some View {
        TodayCard(
            id: 1,
            onRemove: { result, id in
                print("onRemove: \(result), \(id)")
            },
            cardInfo: CardInfo(
                image: "date",
                title: "デートしよう",
                userImage: "profile_default",
                userName: "ママ",
                content: "おいしいもの食べにいきたいんだけどうどうかなぁ？"
            )
        )
        .frame(height: 400)
    }
}
