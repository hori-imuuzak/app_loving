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

    @State private var userId: String = ""
    @State private var name: String = ""
    @State private var comment: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ProfileAccount(
                        name: self.name,
                        profileImageUrl: "http://placeimg.com/350/250/people",
                        coverImageUrl: "https://i.picsum.photos/id/1041/350/250.jpg",
                        onSaveName: self.updateName
                    )
                    ProfileContent(
                        comment: self.comment,
                        onSaveComment: self.updateComment
                    )
                    Spacer().frame(height: 160)
                }
            }
            .navigationBarTitle(Text("設定"))
        }.onAppear(perform: {
            self.viewModel.getUser()
            
            self.viewModel.outputs.userId.subscribe(onNext: { value in
                self.userId = value
            }).disposed(by: self.disposeBag)
            
            self.viewModel.outputs.name.subscribe(onNext: { value in
                self.name = value
            }).disposed(by: self.disposeBag)
            
            self.viewModel.outputs.comment.subscribe(onNext: { value in
                self.comment = value
            }).disposed(by: self.disposeBag)
        })
    }
    
    private func updateName(name: String) {
        self.viewModel.updateName(name)
    }
    
    private func updateComment(comment: String) {
        self.viewModel.updateComment(comment)
    }
}

#if DEBUG
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
