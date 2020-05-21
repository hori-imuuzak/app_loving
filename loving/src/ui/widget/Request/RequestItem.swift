//
//  RequestItem.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct Request: Identifiable {
    let id = UUID()
    let image: String
    let text: String
}

struct RequestItem: View {
    let request: Request

    var body: some View {
        ZStack {
            Image(request.image)
                .resizable()
                .scaledToFill()
            Text(request.text)
                .fontWeight(.bold)
                .shadow(color: Color.black, radius: Const.Shadow, x: 0, y: 0)
                .font(.system(size: Const.FontSize.M))
                .padding(Const.Padding.M)
                .foregroundColor(Color.white)
                .lineLimit(3)
                .frame(width: 120)
        }
        .frame(width: 120, height: 120)
        .clipped()
    }
}

struct RequestItem_Previews: PreviewProvider {
    static var previews: some View {
        RequestItem(request: Request(
            image: "pocket_money",
            text: "おこづかいが\nほしい"
        ))
    }
}
