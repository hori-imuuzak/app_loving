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
        Request(image: "date", text: "お出かけしたい"),
        Request(image: "cooking", text: "料理をしてほしい"),
        Request(image: "shopping", text: "買い物してほしい"),
        Request(image: "movie", text: "映画をみたい"),
        Request(image: "drive", text: "ドライブに\n行きたい"),
        Request(image: "pocket_money", text: "おこづかいが\nほしい"),
        Request(image: "clean_up", text: "片付けをお願い"),
        Request(image: "sports", text: "一緒に運動したい"),
        Request(image: "wake_up", text: "起こしてほしい"),
        Request(image: "bathing", text: "お風呂をためてほしい"),
        Request(image: "messenger", text: "電話やメッセージしたい"),
        Request(image: "work", text: "お仕事がんばって！"),
        Request(image: "custom_request", text: "その他のリクエスト"),
    ]
    
    var body: some View {
        NavigationView {
            QGrid(requests, columns: 3, vSpacing: 4, hSpacing: 18) { request in
                RequestItem(request: request)
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
