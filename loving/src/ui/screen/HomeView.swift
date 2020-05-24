//
//  ContentView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/19.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import RxSwift

struct HomeView: View {
    private let viewModel = HomeViewModel(
        userRepository: FirebaseUserRepository.instance
    )
    private let disposeBag = DisposeBag()
    
    @State private var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                App()
            } else {
                SplashView()
            }
        }.onAppear(perform: {
            let auth = Auth.auth()
            if auth.currentUser != nil {
                // 未ログインならログイン後、ユーザー作成をする
                // TODO: 本当はユーザーから初期ユーザー名を入力してもらう
                Auth.auth().signInAnonymously { _, err in
                    if err == nil {
                        self.viewModel.createUser()
                        self.viewModel.isCreated.subscribe(onNext: { isCreated in
                            if isCreated {
                                self.hideSplash(delay: 2.5)
                            }
                        }).disposed(by: self.disposeBag)
                    }
                }
            } else {
                self.hideSplash(delay: 2.5)
            }
        })
    }
    
    func hideSplash(delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isActive = true
        }
    }
}

struct App: View {
    var body: some View {
        TabView {
            CardStack()
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
