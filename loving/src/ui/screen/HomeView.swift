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
                    Image(systemName: "phone.fill")
                    Text("Todays")
            }
            PartnerList(partners: [
                PartnerItem(id: 1, name: "旦那さん"),
                PartnerItem(id: 2, name: "ママ"),
                PartnerItem(id: 3, name: "息子ちゃん")
            ])
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Partners")
            }
            RequestList()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Requests")
            }
            ProfileView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Settings")
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
