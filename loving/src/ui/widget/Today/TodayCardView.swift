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
    
    private var onRemove: (_ status: SwipeStatus) -> Void
    
    // 50%ドラッグで削除する
    private let removeThresholdPercentage: CGFloat = 0.5
    
    enum SwipeStatus: Int {
        case accept, deny, none
    }
    
    init(onRemove: @escaping (_ status: SwipeStatus) -> Void) {
        self.onRemove = onRemove
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
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
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(Const.CornerRadius)
            .shadow(radius: Const.Shadow)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 0.25), anchor: .bottom)
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
                            self.onRemove(self.swipeStatus)
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

struct TodayCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayCard(onRemove: { result in
            print("onRemove: \(result)")
        })
            .frame(height: 400)
    }
}
