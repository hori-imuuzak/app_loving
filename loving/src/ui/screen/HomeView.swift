//
//  ContentView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/19.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Text("本日のリクエスト")
                .tabItem {
                    Image("today")
                        .renderingMode(.template)
                    Text("本日のリクエスト")
                }
            PartnerList(partners: [
                PartnerItem(name: "旦那さん"),
                PartnerItem(name: "ママ"),
                PartnerItem(name: "息子ちゃん")
            ])
                .tabItem {
                    Image("father")
                        .renderingMode(.template)
                    Text("パートナー")
            }
            RequestList()
                .tabItem {
                    Image("pray")
                        .renderingMode(.template)
                    Text("リクエスト")
            }
            ProfileView()
                .tabItem {
                    Image("settings")
                        .renderingMode(.template)
                    Text("設定")
            }
        }
    }
}

#if DEBUG
struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
