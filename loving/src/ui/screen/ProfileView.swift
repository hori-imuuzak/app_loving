//
//  ProfileView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/19.
//  Copyright © 2020 umiapp. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage
import RxSwift

struct ProfileView: View {
    
    private let viewModel = ProfileViewModel(
        userRepository: FirebaseUserRepository.instance
    )
    private let disposeBag = DisposeBag()

    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ProfileAccount(
                        name: self.name,
                        profileImageUrl: "http://placeimg.com/350/250/people",
                        coverImageUrl: "https://i.picsum.photos/id/1041/350/250.jpg"
                    )
                    ProfileContent()
                    Spacer().frame(height: 160)
                }
            }
            .navigationBarTitle(Text("設定"))
        }.onAppear(perform: {
            self.viewModel.getUser()
            
            self.viewModel.outputs.name.subscribe(onNext: { name in
                self.name = name
            }).disposed(by: self.disposeBag)
        })
    }
}

#if DEBUG
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
