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

struct ProfileScreen: View {
    
    private let viewModel = ProfileViewModel(
        accountRepository: FirebaseAccountRepository.instance,
        userRepository: FirebaseUserRepository.instance,
        storage: FirebaseStorageImpl()
    )
    private let disposeBag = DisposeBag()

    @State private var userId: String = ""
    @State private var name: String = ""
    @State private var profileImageUrl: String = ""
    @State private var coverImageUrl: String = ""
    @State private var comment: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                ProfileAccount(
                    name: self.name,
                    profileImageUrl: self.profileImageUrl,
                    coverImageUrl: self.coverImageUrl,
                    onSaveName: self.updateName
                )
                ProfileContent(
                    uid: self.userId,
                    comment: self.comment,
                    onSaveComment: self.updateComment
                )
                Spacer().frame(height: 160)
            }
            .navigationBarTitle(Text("設定"))
        }.onAppear(perform: {
            self.viewModel.getUser()
            self.observe()
        })
    }
    
    private func observe() {
        self.viewModel.outputs.userId.subscribe(onNext: { value in
            self.userId = value
        }).disposed(by: self.disposeBag)
        
        self.viewModel.outputs.name.subscribe(onNext: { value in
            self.name = value
        }).disposed(by: self.disposeBag)
        
        self.viewModel.outputs.profileImageUrl.subscribe(onNext: { value in
            self.profileImageUrl = value
        }).disposed(by: self.disposeBag)
        
        self.viewModel.outputs.coverImageUrl.subscribe(onNext: { value in
            self.coverImageUrl = value
        }).disposed(by: self.disposeBag)
        
        self.viewModel.outputs.comment.subscribe(onNext: { value in
            self.comment = value
        }).disposed(by: self.disposeBag)
    }
    
    private func updateName(name: String) {
        self.viewModel.inputs.updateName(name)
    }
    
    private func updateComment(comment: String) {
        self.viewModel.inputs.updateComment(comment)
    }
}

#if DEBUG
struct ProfileScreen_Preview: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
#endif
