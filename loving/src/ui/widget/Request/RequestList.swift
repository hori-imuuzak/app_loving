//
//  RequestList.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import QGrid

struct Row: Identifiable {
    let id = UUID()
    let cells: [Request]
}

struct RequestList: View {
    let requests = [
        RequestData(image: "date", text: "お出かけしたい"),
        RequestData(image: "cooking", text: "料理をしてほしい"),
        RequestData(image: "shopping", text: "買い物してほしい"),
        RequestData(image: "movie", text: "映画をみたい"),
        RequestData(image: "drive", text: "ドライブに\n行きたい"),
        RequestData(image: "pocket_money", text: "おこづかいが\nほしい"),
        RequestData(image: "clean_up", text: "片付けをお願い"),
        RequestData(image: "sports", text: "一緒に運動したい"),
        RequestData(image: "wake_up", text: "起こしてほしい"),
        RequestData(image: "bathing", text: "お風呂をためてほしい"),
        RequestData(image: "messenger", text: "電話やメッセージしたい"),
        RequestData(image: "work", text: "お仕事がんばって！"),
        RequestData(image: "custom_request", text: "その他のリクエスト"),
    ]
    
    var body: some View {
        NavigationView {
            QGrid(requests, columns: 3, vSpacing: 4, hSpacing: 18, vPadding: 0) { request in
                NavigationLink(destination: RequestTo(partners: [
                        // TODO
                        PartnerItem(name: "旦那さん"),
                        PartnerItem(name: "ママ"),
                        PartnerItem(name: "息子ちゃん")
                    ])
                ) {
                    RequestItem(request: request)
                }.buttonStyle(PlainButtonStyle())
            }
            .navigationBarTitle(Text("リクエストを送る"))
            
        }
    }
}

struct RequestList_Previews: PreviewProvider {
    static var previews: some View {
        RequestList()
    }
}
