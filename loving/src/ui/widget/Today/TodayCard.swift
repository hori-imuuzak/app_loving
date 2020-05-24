//
//  TodayCardView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct TodayCard: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: SwipeStatus = .none
    
    private var id: Int
    private var onRemove: (_ status: SwipeStatus, _ id: Int) -> Void
    
    // 50%ドラッグで削除する
    private let removeThresholdPercentage: CGFloat = 0.5
    
    enum SwipeStatus: Int {
        case accept, deny, none
    }
    
    init(id: Int, onRemove: @escaping (_ status: SwipeStatus, _ id: Int) -> Void) {
        self.id = id
        self.onRemove = onRemove
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image("date")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .clipped()
                HStack {
                    VStack(alignment: .leading, spacing: Const.Padding.M) {
                        Text("ほげほげ")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundColor(Color.gray)
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
        TodayCard(id: 1, onRemove: { result, id in
            print("onRemove: \(result), \(id)")
        })
            .frame(height: 400)
    }
}
