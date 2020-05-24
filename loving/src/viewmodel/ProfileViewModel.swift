//
//  ProfileViewModel.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift
import FirebaseAuth

protocol ProfileViewModelInputs {
    func getUser()
}

protocol ProfileViewModelOutputs {
    var name: Observable<String> { get }
}

protocol ProfileViewModelType {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModel: ProfileViewModelType, ProfileViewModelInputs, ProfileViewModelOutputs {
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private var disposeBag = DisposeBag()
    private var userRepository: UserRepository
    
    var inputs: ProfileViewModelInputs { return self }
    var outputs: ProfileViewModelOutputs { return self }
    
    private var userSubject = PublishSubject<User>()
    
    var name: Observable<String> { return userSubject.map({ $0.name }) }
    
    func getUser() {
        if let uid = Auth.auth().currentUser?.uid {
            self.userRepository.get(uid: uid).subscribe(onNext: { user in
                self.userSubject.onNext(user)
            }).disposed(by: disposeBag)
        }
    }
}
