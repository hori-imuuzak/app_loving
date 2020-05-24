//
//  HomeViewModel.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift
import FirebaseAuth

protocol HomeViewModelInputs {
    func createUser()
}

protocol HomeViewModelOutputs {
    var isCreated: Observable<Bool> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private var disposeBag = DisposeBag()
    private var userRepository: UserRepository
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
    private var isCreatedSubject = PublishSubject<Bool>()
    
    var isCreated: Observable<Bool> { return isCreatedSubject }
    
    func createUser() {
        if let uid = Auth.auth().currentUser?.uid {
            let user = User(
                uid: uid,
                name: "test",
                comment: "おねだり待ってます！",
                profileImageUrl: "",
                profileCoverUrl: ""
            )
            self.userRepository.create(user: user).subscribe(onNext: { user in
                self.isCreatedSubject.onNext(true)
            }).disposed(by: disposeBag)
        }
    }
}